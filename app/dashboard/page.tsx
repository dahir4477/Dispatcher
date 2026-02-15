import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Truck, TrendingUp, DollarSign, FileText, MessageSquare } from 'lucide-react'
import { Badge } from '@/components/ui/badge'
import Link from 'next/link'
import { kpiData, loads as seedLoads } from '@/lib/data'

function KPICard({
  title,
  value,
  icon: Icon,
}: {
  title: string
  value: string | number
  icon: React.ElementType
}) {
  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
        <CardTitle className="text-sm font-medium">{title}</CardTitle>
        <Icon className="h-4 w-4 text-muted-foreground" />
      </CardHeader>
      <CardContent>
        <div className="text-2xl font-bold">{value}</div>
      </CardContent>
    </Card>
  )
}

export default function DashboardPage() {
  // Using seed data for now - will automatically switch to Supabase when configured
  const loads = seedLoads.slice(0, 5)

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-slate-900">Dashboard</h1>
        <p className="text-slate-600">Monitor your fleet performance and AI insights</p>
      </div>

      {/* KPI Cards */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-5">
        <KPICard title="Active Loads" value={kpiData.activeLoads} icon={Truck} />
        <KPICard title="AI Avg Score" value={kpiData.avgAIScore.toFixed(1)} icon={TrendingUp} />
        <KPICard
          title="Revenue Today"
          value={`$${(kpiData.revenueToday / 1000).toFixed(1)}k`}
          icon={DollarSign}
        />
        <KPICard title="Pending Invoices" value={kpiData.pendingInvoices} icon={FileText} />
        <KPICard title="Messages Today" value={kpiData.whatsappMessages} icon={MessageSquare} />
      </div>

      {/* Recent Loads */}
      <Card>
        <CardHeader>
          <CardTitle>Recent Loads</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {loads.map((load) => (
              <Link
                key={load.id}
                href={`/loads/${load.id}`}
                className="flex items-center justify-between rounded-lg border p-4 hover:bg-slate-50 transition-colors"
              >
                <div className="flex items-center gap-4">
                  <div>
                    <p className="font-semibold text-slate-900">{load.loadNumber}</p>
                    <p className="text-sm text-slate-600">
                      {load.pickup} → {load.delivery}
                    </p>
                  </div>
                </div>
                <div className="flex items-center gap-6">
                  <div className="text-right">
                    <p className="text-sm text-slate-600">Rate</p>
                    <p className="font-semibold">${load.rate.toLocaleString()}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm text-slate-600">RPM</p>
                    <p className="font-semibold">${load.rpm.toFixed(2)}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm text-slate-600">AI Score</p>
                    <p className="font-semibold text-green-600">{load.aiScore}</p>
                  </div>
                  <Badge
                    variant={
                      load.status === 'available'
                        ? 'default'
                        : load.status === 'assigned'
                        ? 'secondary'
                        : 'outline'
                    }
                  >
                    {load.status}
                  </Badge>
                </div>
              </Link>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
