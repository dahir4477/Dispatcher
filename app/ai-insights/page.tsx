import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { TrendingUp } from 'lucide-react'

export default function AIInsightsPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-slate-900">AI Insights</h1>
        <p className="text-slate-600">Data-driven recommendations for your fleet</p>
      </div>

      <Card>
        <CardHeader>
          <div className="flex items-center gap-3">
            <TrendingUp className="h-6 w-6 text-green-600" />
            <CardTitle>Top Performing Lanes</CardTitle>
          </div>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            <div className="flex justify-between">
              <span className="text-sm text-slate-600">Atlanta → Miami</span>
              <span className="font-semibold">$4.2 RPM</span>
            </div>
            <div className="flex justify-between">
              <span className="text-sm text-slate-600">LA → Phoenix</span>
              <span className="font-semibold">$4.5 RPM</span>
            </div>
            <div className="flex justify-between">
              <span className="text-sm text-slate-600">Chicago → Dallas</span>
              <span className="font-semibold">$3.8 RPM</span>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
