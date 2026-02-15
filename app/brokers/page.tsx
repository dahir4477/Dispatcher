import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { brokers } from '@/lib/data'

export default function BrokersPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-slate-900">Brokers</h1>
        <p className="text-slate-600">Manage broker relationships</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>All Brokers</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {brokers.map((broker) => (
              <div key={broker.id} className="flex items-center justify-between rounded-lg border p-4">
                <div>
                  <p className="font-semibold">{broker.companyName}</p>
                  <p className="text-sm text-slate-600">{broker.contactName}</p>
                </div>
                <div className="flex items-center gap-6">
                  <div className="text-right">
                    <p className="text-sm text-slate-600">Reliability</p>
                    <p className="font-semibold text-green-600">{broker.paymentReliability}%</p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm text-slate-600">Total Loads</p>
                    <p className="font-semibold">{broker.totalLoads}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm text-slate-600">Revenue</p>
                    <p className="font-semibold">${(broker.totalRevenue / 1000).toFixed(0)}k</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
