import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { loads } from '@/lib/data'
import { Badge } from '@/components/ui/badge'
import Link from 'next/link'

export default function LoadsPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-slate-900">Loads</h1>
        <p className="text-slate-600">Manage and track all your loads</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>All Loads</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {loads.map((load) => (
              <Link
                key={load.id}
                href={`/loads/${load.id}`}
                className="flex items-center justify-between rounded-lg border p-4 hover:bg-slate-50"
              >
                <div>
                  <p className="font-semibold">{load.loadNumber}</p>
                  <p className="text-sm text-slate-600">
                    {load.pickup} → {load.delivery}
                  </p>
                </div>
                <div className="flex items-center gap-4">
                  <div className="text-right">
                    <p className="text-sm text-slate-600">AI Score</p>
                    <p className="font-semibold text-green-600">{load.aiScore}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm text-slate-600">Rate</p>
                    <p className="font-semibold">${load.rate.toLocaleString()}</p>
                  </div>
                  <Badge>{load.status}</Badge>
                </div>
              </Link>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
