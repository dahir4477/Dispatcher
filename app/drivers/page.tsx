import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { drivers } from '@/lib/data'
import { Badge } from '@/components/ui/badge'

export default function DriversPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-slate-900">Drivers</h1>
        <p className="text-slate-600">Manage your fleet drivers</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>All Drivers</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {drivers.map((driver) => (
              <div key={driver.id} className="flex items-center justify-between rounded-lg border p-4">
                <div>
                  <p className="font-semibold">{driver.name}</p>
                  <p className="text-sm text-slate-600">{driver.phone}</p>
                </div>
                <div className="flex items-center gap-4">
                  <div className="text-right">
                    <p className="text-sm text-slate-600">Location</p>
                    <p className="font-semibold">{driver.location}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm text-slate-600">Total Loads</p>
                    <p className="font-semibold">{driver.totalLoads}</p>
                  </div>
                  <Badge variant={driver.status === 'available' ? 'default' : 'secondary'}>
                    {driver.status}
                  </Badge>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
