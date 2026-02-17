-- Hybrid AI Dispatch - Database Schema
-- This SQL should be run in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create users table (extends auth.users)
CREATE TABLE public.users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL UNIQUE,
  role TEXT NOT NULL CHECK (role IN ('admin', 'dispatcher', 'broker', 'driver')),
  fleet_id UUID NOT NULL,
  full_name TEXT,
  phone TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create brokers table
CREATE TABLE public.brokers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  fleet_id UUID NOT NULL,
  company_name TEXT NOT NULL,
  mc_number TEXT NOT NULL,
  contact_name TEXT,
  phone TEXT NOT NULL,
  email TEXT,
  payment_terms INTEGER DEFAULT 30,
  avg_payment_days NUMERIC DEFAULT 30,
  payment_reliability NUMERIC DEFAULT 100 CHECK (payment_reliability >= 0 AND payment_reliability <= 100),
  total_loads INTEGER DEFAULT 0,
  total_revenue NUMERIC DEFAULT 0,
  dispute_rate NUMERIC DEFAULT 0 CHECK (dispute_rate >= 0 AND dispute_rate <= 1),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create drivers table
CREATE TABLE public.drivers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  fleet_id UUID NOT NULL,
  full_name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  license_number TEXT NOT NULL,
  license_state TEXT NOT NULL,
  equipment_type TEXT NOT NULL,
  status TEXT DEFAULT 'available' CHECK (status IN ('available', 'on_load', 'off_duty')),
  current_location_city TEXT,
  current_location_state TEXT,
  total_loads INTEGER DEFAULT 0,
  total_revenue NUMERIC DEFAULT 0,
  avg_rating NUMERIC CHECK (avg_rating >= 0 AND avg_rating <= 5),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create loads table
CREATE TABLE public.loads (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  fleet_id UUID NOT NULL,
  load_number TEXT NOT NULL UNIQUE,
  broker_id UUID NOT NULL REFERENCES public.brokers(id),
  driver_id UUID REFERENCES public.drivers(id),
  pickup_location TEXT NOT NULL,
  pickup_city TEXT NOT NULL,
  pickup_state TEXT NOT NULL,
  pickup_date TIMESTAMPTZ NOT NULL,
  delivery_location TEXT NOT NULL,
  delivery_city TEXT NOT NULL,
  delivery_state TEXT NOT NULL,
  delivery_date TIMESTAMPTZ NOT NULL,
  rate NUMERIC NOT NULL,
  distance INTEGER NOT NULL,
  rpm NUMERIC NOT NULL,
  weight INTEGER NOT NULL,
  equipment_type TEXT NOT NULL,
  commodity TEXT,
  status TEXT DEFAULT 'available' CHECK (status IN ('available', 'assigned', 'in_transit', 'delivered', 'invoiced', 'paid')),
  ai_score NUMERIC CHECK (ai_score >= 0 AND ai_score <= 10),
  ai_recommendation TEXT,
  ai_risk_level TEXT CHECK (ai_risk_level IN ('Low', 'Medium', 'High')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create invoices table
CREATE TABLE public.invoices (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  fleet_id UUID NOT NULL,
  load_id UUID NOT NULL REFERENCES public.loads(id),
  invoice_number TEXT NOT NULL UNIQUE,
  broker_id UUID NOT NULL REFERENCES public.brokers(id),
  amount NUMERIC NOT NULL,
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'sent', 'paid', 'overdue')),
  due_date DATE NOT NULL,
  paid_date DATE,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create messages table
CREATE TABLE public.messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  fleet_id UUID NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('whatsapp', 'email', 'sms')),
  direction TEXT NOT NULL CHECK (direction IN ('inbound', 'outbound')),
  from_phone TEXT,
  to_phone TEXT,
  from_email TEXT,
  to_email TEXT,
  subject TEXT,
  body TEXT NOT NULL,
  load_id UUID REFERENCES public.loads(id),
  driver_id UUID REFERENCES public.drivers(id),
  broker_id UUID REFERENCES public.brokers(id),
  status TEXT DEFAULT 'sent' CHECK (status IN ('sent', 'delivered', 'read', 'failed')),
  external_id TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create documents table
CREATE TABLE public.documents (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  fleet_id UUID NOT NULL,
  load_id UUID NOT NULL REFERENCES public.loads(id),
  type TEXT NOT NULL CHECK (type IN ('pod', 'bol', 'rate_con', 'invoice', 'other')),
  file_name TEXT NOT NULL,
  file_url TEXT NOT NULL,
  file_size INTEGER NOT NULL,
  uploaded_by UUID NOT NULL REFERENCES public.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create ai_scores table
CREATE TABLE public.ai_scores (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  load_id UUID NOT NULL REFERENCES public.loads(id),
  fleet_id UUID NOT NULL,
  score NUMERIC NOT NULL CHECK (score >= 0 AND score <= 10),
  risk_level TEXT NOT NULL CHECK (risk_level IN ('Low', 'Medium', 'High')),
  recommendation TEXT NOT NULL CHECK (recommendation IN ('Accept', 'Negotiate', 'Reject')),
  explanation TEXT NOT NULL,
  rpm_score NUMERIC NOT NULL,
  broker_score NUMERIC NOT NULL,
  efficiency_score NUMERIC NOT NULL,
  timing_score NUMERIC NOT NULL,
  profitability_score NUMERIC NOT NULL,
  suggested_rate NUMERIC,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX idx_loads_fleet_id ON public.loads(fleet_id);
CREATE INDEX idx_loads_status ON public.loads(status);
CREATE INDEX idx_loads_driver_id ON public.loads(driver_id);
CREATE INDEX idx_loads_broker_id ON public.loads(broker_id);
CREATE INDEX idx_messages_fleet_id ON public.messages(fleet_id);
CREATE INDEX idx_messages_load_id ON public.messages(load_id);
CREATE INDEX idx_invoices_fleet_id ON public.invoices(fleet_id);
CREATE INDEX idx_invoices_status ON public.invoices(status);
CREATE INDEX idx_drivers_fleet_id ON public.drivers(fleet_id);
CREATE INDEX idx_drivers_status ON public.drivers(status);
CREATE INDEX idx_brokers_fleet_id ON public.brokers(fleet_id);

-- Enable Row Level Security
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.loads ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.drivers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.brokers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.invoices ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ai_scores ENABLE ROW LEVEL SECURITY;

-- Create RLS Policies
-- Users can only see their own fleet data

CREATE POLICY "Users can view own fleet data"
  ON public.users FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Loads visible to fleet members"
  ON public.loads FOR ALL
  USING (
    fleet_id IN (
      SELECT fleet_id FROM public.users WHERE id = auth.uid()
    )
  );

CREATE POLICY "Drivers visible to fleet members"
  ON public.drivers FOR ALL
  USING (
    fleet_id IN (
      SELECT fleet_id FROM public.users WHERE id = auth.uid()
    )
  );

CREATE POLICY "Brokers visible to fleet members"
  ON public.brokers FOR ALL
  USING (
    fleet_id IN (
      SELECT fleet_id FROM public.users WHERE id = auth.uid()
    )
  );

CREATE POLICY "Invoices visible to fleet members"
  ON public.invoices FOR ALL
  USING (
    fleet_id IN (
      SELECT fleet_id FROM public.users WHERE id = auth.uid()
    )
  );

CREATE POLICY "Messages visible to fleet members"
  ON public.messages FOR ALL
  USING (
    fleet_id IN (
      SELECT fleet_id FROM public.users WHERE id = auth.uid()
    )
  );

CREATE POLICY "Documents visible to fleet members"
  ON public.documents FOR ALL
  USING (
    fleet_id IN (
      SELECT fleet_id FROM public.users WHERE id = auth.uid()
    )
  );

CREATE POLICY "AI Scores visible to fleet members"
  ON public.ai_scores FOR ALL
  USING (
    fleet_id IN (
      SELECT fleet_id FROM public.users WHERE id = auth.uid()
    )
  );

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Add updated_at triggers
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_loads_updated_at BEFORE UPDATE ON public.loads
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_drivers_updated_at BEFORE UPDATE ON public.drivers
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_brokers_updated_at BEFORE UPDATE ON public.brokers
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_invoices_updated_at BEFORE UPDATE ON public.invoices
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
