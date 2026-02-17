-- Seed Data for Hybrid AI Dispatch
-- Run this after creating the schema

-- Insert a test fleet
INSERT INTO public.users (id, email, role, fleet_id, full_name, phone)
VALUES 
  ('00000000-0000-0000-0000-000000000001', 'admin@raydab.com', 'admin', '11111111-1111-1111-1111-111111111111', 'Admin User', '(555) 100-0001'),
  ('00000000-0000-0000-0000-000000000002', 'dispatcher@raydab.com', 'dispatcher', '11111111-1111-1111-1111-111111111111', 'John Dispatcher', '(555) 100-0002');

-- Insert brokers
INSERT INTO public.brokers (id, fleet_id, company_name, mc_number, contact_name, phone, email, payment_terms, avg_payment_days, payment_reliability, total_loads, total_revenue, dispute_rate)
VALUES
  ('b1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', 'TQL Logistics', 'MC-123456', 'Robert Johnson', '(513) 555-0123', 'dispatch@tql.com', 30, 28, 98, 145, 362500, 0.02),
  ('b2222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'C.H. Robinson', 'MC-234567', 'Jennifer Smith', '(952) 555-0456', 'carriers@chrobinson.com', 30, 32, 95, 98, 245000, 0.03),
  ('b3333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', 'Landstar', 'MC-345678', 'Michael Davis', '(904) 555-0789', 'capacity@landstar.com', 45, 38, 92, 76, 190000, 0.05);

-- Insert drivers
INSERT INTO public.drivers (id, fleet_id, full_name, phone, email, license_number, license_state, equipment_type, status, current_location_city, current_location_state, total_loads, total_revenue, avg_rating)
VALUES
  ('d1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', 'John Smith', '(555) 123-4567', 'john.smith@email.com', 'CDL-123456', 'GA', 'Dry Van', 'available', 'Atlanta', 'GA', 142, 284000, 4.8),
  ('d2222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Mike Johnson', '(555) 234-5678', 'mike.johnson@email.com', 'CDL-234567', 'TX', 'Reefer', 'on_load', 'Dallas', 'TX', 98, 196000, 4.6),
  ('d3333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', 'Sarah Williams', '(555) 345-6789', 'sarah.williams@email.com', 'CDL-345678', 'CA', 'Flatbed', 'available', 'Los Angeles', 'CA', 156, 312000, 4.9),
  ('d4444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', 'David Brown', '(555) 456-7890', 'david.brown@email.com', 'CDL-456789', 'FL', 'Dry Van', 'on_load', 'Miami', 'FL', 87, 174000, 4.5),
  ('d5555555-5555-5555-5555-555555555555', '11111111-1111-1111-1111-111111111111', 'Lisa Davis', '(555) 567-8901', 'lisa.davis@email.com', 'CDL-567890', 'IL', 'Dry Van', 'off_duty', 'Chicago', 'IL', 201, 402000, 4.7);

-- Insert loads
INSERT INTO public.loads (id, fleet_id, load_number, broker_id, driver_id, pickup_location, pickup_city, pickup_state, pickup_date, delivery_location, delivery_city, delivery_state, delivery_date, rate, distance, rpm, weight, equipment_type, commodity, status, ai_score, ai_recommendation, ai_risk_level)
VALUES
  ('l1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', 'LD-2401', 'b1111111-1111-1111-1111-111111111111', NULL, '2500 Marietta Blvd NW, Atlanta, GA 30318', 'Atlanta', 'GA', '2024-02-20 08:00:00', '7800 NW 25th St, Miami, FL 33122', 'Miami', 'FL', '2024-02-21 14:00:00', 2400, 660, 3.64, 42000, 'Dry Van', 'Electronics', 'available', 9.1, 'Accept', 'Low'),
  ('l2222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'LD-2402', 'b2222222-2222-2222-2222-222222222222', 'd1111111-1111-1111-1111-111111111111', '500 W Madison St, Chicago, IL 60661', 'Chicago', 'IL', '2024-02-21 09:00:00', '2100 Ross Ave, Dallas, TX 75201', 'Dallas', 'TX', '2024-02-22 17:00:00', 3200, 925, 3.46, 38000, 'Dry Van', 'Furniture', 'assigned', 8.5, 'Accept', 'Low'),
  ('l3333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', 'LD-2403', 'b3333333-3333-3333-3333-333333333333', 'd2222222-2222-2222-2222-222222222222', '1201 S Figueroa St, Los Angeles, CA 90015', 'Los Angeles', 'CA', '2024-02-19 07:00:00', '201 N Central Ave, Phoenix, AZ 85004', 'Phoenix', 'AZ', '2024-02-19 18:00:00', 1800, 373, 4.83, 35000, 'Reefer', 'Food Products', 'in_transit', 9.3, 'Accept', 'Low'),
  ('l4444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', 'LD-2404', 'b1111111-1111-1111-1111-111111111111', NULL, '350 5th Ave, New York, NY 10118', 'New York', 'NY', '2024-02-22 10:00:00', '1 City Hall Square, Boston, MA 02201', 'Boston', 'MA', '2024-02-22 16:00:00', 850, 215, 3.95, 28000, 'Dry Van', 'Clothing', 'available', 7.8, 'Accept', 'Medium'),
  ('l5555555-5555-5555-5555-555555555555', '11111111-1111-1111-1111-111111111111', 'LD-2405', 'b2222222-2222-2222-2222-222222222222', 'd3333333-3333-3333-3333-333333333333', '1600 Smith St, Houston, TX 77002', 'Houston', 'TX', '2024-02-18 08:00:00', '100 N Main St, Memphis, TN 38103', 'Memphis', 'TN', '2024-02-19 15:00:00', 2200, 565, 3.89, 44000, 'Dry Van', 'Industrial Parts', 'delivered', 8.2, 'Accept', 'Low'),
  ('l6666666-6666-6666-6666-666666666666', '11111111-1111-1111-1111-111111111111', 'LD-2406', 'b3333333-3333-3333-3333-333333333333', NULL, '1720 Welton St, Denver, CO 80202', 'Denver', 'CO', '2024-02-23 09:00:00', '50 S Main St, Salt Lake City, UT 84101', 'Salt Lake City', 'UT', '2024-02-24 14:00:00', 1600, 525, 3.05, 40000, 'Dry Van', 'Building Materials', 'available', 6.5, 'Negotiate', 'Medium'),
  ('l7777777-7777-7777-7777-777777777777', '11111111-1111-1111-1111-111111111111', 'LD-2407', 'b1111111-1111-1111-1111-111111111111', 'd4444444-4444-4444-4444-444444444444', '400 Broad St, Seattle, WA 98109', 'Seattle', 'WA', '2024-02-21 11:00:00', '1120 SW 5th Ave, Portland, OR 97204', 'Portland', 'OR', '2024-02-21 17:00:00', 650, 173, 3.76, 32000, 'Dry Van', 'Retail Goods', 'assigned', 8.9, 'Accept', 'Low'),
  ('l8888888-8888-8888-8888-888888888888', '11111111-1111-1111-1111-111111111111', 'LD-2408', 'b2222222-2222-2222-2222-222222222222', 'd5555555-5555-5555-5555-555555555555', '500 Griswold St, Detroit, MI 48226', 'Detroit', 'MI', '2024-02-20 08:00:00', '200 Public Square, Cleveland, OH 44114', 'Cleveland', 'OH', '2024-02-20 13:00:00', 550, 170, 3.24, 25000, 'Dry Van', 'Auto Parts', 'in_transit', 7.1, 'Accept', 'Medium'),
  ('l9999999-9999-9999-9999-999999999999', '11111111-1111-1111-1111-111111111111', 'LD-2409', 'b2222222-2222-2222-2222-222222222222', NULL, '300 Broadway, Nashville, TN 37201', 'Nashville', 'TN', '2024-02-22 10:00:00', '241 Peachtree St NE, Atlanta, GA 30303', 'Atlanta', 'GA', '2024-02-22 16:00:00', 980, 250, 3.92, 30000, 'Dry Van', 'Music Equipment', 'available', 8.7, 'Accept', 'Low'),
  ('la111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', 'LD-2410', 'b3333333-3333-3333-3333-333333333333', NULL, '125 E Washington St, Phoenix, AZ 85004', 'Phoenix', 'AZ', '2024-02-24 07:00:00', '3730 S Las Vegas Blvd, Las Vegas, NV 89158', 'Las Vegas', 'NV', '2024-02-24 14:00:00', 1100, 297, 3.70, 36000, 'Dry Van', 'Hospitality Supplies', 'available', 8.0, 'Accept', 'Low');

-- Insert AI scores
INSERT INTO public.ai_scores (load_id, fleet_id, score, risk_level, recommendation, explanation, rpm_score, broker_score, efficiency_score, timing_score, profitability_score, suggested_rate)
VALUES
  ('l1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', 9.1, 'Low', 'Accept', 'Excellent RPM of $3.64 (28% above lane average). Highly reliable broker with strong payment history.', 9.2, 9.5, 8.8, 9.0, 8.9, NULL),
  ('l2222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 8.5, 'Low', 'Accept', 'Strong RPM and reliable broker. Good route efficiency.', 8.3, 9.0, 8.5, 8.7, 8.2, NULL),
  ('l3333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', 9.3, 'Low', 'Accept', 'Outstanding RPM of $4.83. Short haul with excellent profitability.', 9.8, 8.8, 9.2, 9.1, 9.5, NULL);

-- Insert invoices
INSERT INTO public.invoices (id, fleet_id, load_id, invoice_number, broker_id, amount, status, due_date, paid_date)
VALUES
  ('i1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', 'l5555555-5555-5555-5555-555555555555', 'INV-2024-001', 'b2222222-2222-2222-2222-222222222222', 2200, 'sent', '2024-03-20', NULL),
  ('i2222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'l3333333-3333-3333-3333-333333333333', 'INV-2024-002', 'b3333333-3333-3333-3333-333333333333', 1800, 'paid', '2024-03-19', '2024-03-15');

-- Insert messages
INSERT INTO public.messages (fleet_id, type, direction, from_phone, to_phone, body, load_id, broker_id, status, external_id)
VALUES
  ('11111111-1111-1111-1111-111111111111', 'whatsapp', 'inbound', '+15135550123', '+15555551000', 'Load LD-2401 available. Rate: $2400. Pickup tomorrow 8 AM Atlanta.', 'l1111111-1111-1111-1111-111111111111', 'b1111111-1111-1111-1111-111111111111', 'delivered', 'wa_msg_001'),
  ('11111111-1111-1111-1111-111111111111', 'whatsapp', 'outbound', '+15555551000', '+15135550123', 'Load looks good. Can we get $2500?', 'l1111111-1111-1111-1111-111111111111', 'b1111111-1111-1111-1111-111111111111', 'delivered', 'wa_msg_002'),
  ('11111111-1111-1111-1111-111111111111', 'email', 'inbound', NULL, NULL, 'dispatch@tql.com', NULL, 'Rate confirmation attached for load LD-2401', 'l1111111-1111-1111-1111-111111111111', 'b1111111-1111-1111-1111-111111111111', 'delivered', NULL);
