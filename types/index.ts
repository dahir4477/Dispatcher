export interface Load {
  id: string
  loadNumber: string
  broker: string
  pickup: string
  delivery: string
  rate: number
  rpm: number
  aiScore: number
  status: 'available' | 'assigned' | 'in_transit' | 'delivered'
  driver: string | null
}

export interface KPIData {
  activeLoads: number
  avgAIScore: number
  revenueToday: number
  pendingInvoices: number
  whatsappMessages: number
}

export interface Driver {
  id: string
  name: string
  phone: string
  status: 'available' | 'on_load' | 'off_duty'
  location: string
  totalLoads: number
  totalRevenue: number
}

export interface Broker {
  id: string
  companyName: string
  contactName: string
  phone: string
  email: string
  paymentReliability: number
  totalLoads: number
  totalRevenue: number
}

export interface Invoice {
  id: string
  invoiceNumber: string
  loadNumber: string
  broker: string
  amount: number
  status: 'draft' | 'sent' | 'paid' | 'overdue'
  dueDate: string
  createdAt: string
}

export type UserRole = 'admin' | 'dispatcher' | 'broker' | 'driver'
