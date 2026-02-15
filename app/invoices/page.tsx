import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { invoices } from '@/lib/data'
import { Badge } from '@/components/ui/badge'

const statusColors = {
  draft: 'default',
  sent: 'secondary',
  paid: 'default',
  overdue: 'destructive',
} as const

export default function InvoicesPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-slate-900">Invoices</h1>
        <p className="text-slate-600">Track and manage invoicing</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>All Invoices</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {invoices.map((invoice) => (
              <div key={invoice.id} className="flex items-center justify-between rounded-lg border p-4">
                <div>
                  <p className="font-semibold">{invoice.invoiceNumber}</p>
                  <p className="text-sm text-slate-600">{invoice.loadNumber}</p>
                </div>
                <div className="flex items-center gap-6">
                  <div className="text-right">
                    <p className="text-sm text-slate-600">Broker</p>
                    <p className="font-semibold">{invoice.broker}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm text-slate-600">Amount</p>
                    <p className="font-semibold">${invoice.amount.toLocaleString()}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm text-slate-600">Due Date</p>
                    <p className="font-semibold">{invoice.dueDate}</p>
                  </div>
                  <Badge variant={statusColors[invoice.status]}>{invoice.status}</Badge>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
