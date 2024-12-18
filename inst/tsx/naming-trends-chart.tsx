import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, Label, ResponsiveContainer } from 'recharts';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';

const NamingTrendsChart = () => {
  const colors = {
    primary: '#FF00FF',
    secondary: '#00FFFF',
    background: '#1E4B7B',
    text: '#FFFFFF'
  };

  const data = [
    { year: 1, joel: 94, menachem: 28 },
    { year: 2, joel: 91, menachem: 24 },
    { year: 3, joel: 80, menachem: 30 },
    { year: 4, joel: 69, menachem: 0 },
    { year: 5, joel: 89, menachem: 8 },
    { year: 6, joel: 100, menachem: 10 },
    { year: 7, joel: 88, menachem: 43 },
    { year: 8, joel: 43, menachem: 41 },
    { year: 9, joel: 21, menachem: 52 },
    { year: 10, joel: 19, menachem: 53 },
    { year: 11, joel: 28, menachem: 68 },
    { year: 12, joel: 0, menachem: 80 },
    { year: 13, joel: 0, menachem: 92 },
    { year: 14, joel: 0, menachem: 56 },
    { year: 15, joel: 0, menachem: 88 },
    { year: 16, joel: 0, menachem: 98 },
    { year: 17, joel: 0, menachem: 70 },
    { year: 18, joel: 0, menachem: 57 },
    { year: 19, joel: 0, menachem: 51 },
    { year: 20, joel: 0, menachem: 100 },
    { year: 21, joel: 0, menachem: 68 },
    { year: 22, joel: 0, menachem: 92 },
    { year: 23, joel: 0, menachem: 82 },
    { year: 24, joel: 0, menachem: 77 },
    { year: 25, joel: 0, menachem: 58 },
    { year: 26, joel: 0, menachem: 86 },
    { year: 27, joel: 0, menachem: 90 },
    { year: 28, joel: 0, menachem: 96 }
  ];

  return (
    <Card className="w-full max-w-4xl" style={{ background: colors.background }}>
      <CardHeader className="text-center pb-2">
        <CardTitle className="text-3xl font-bold" style={{ color: colors.text }}>
          Naming Trends After Hasidic Rebbes' Deaths
        </CardTitle>
        <p className="text-sm mt-1" style={{ color: 'rgba(255, 255, 255, 0.8)' }}>
          Percentage of names relative to peak frequency
        </p>
      </CardHeader>
      <CardContent className="p-6">
        <div className="w-full" style={{ minHeight: "400px" }}>
          <ResponsiveContainer width="100%" height={400}>
            <LineChart
              data={data}
              margin={{ top: 20, right: 30, left: 20, bottom: 40 }}
            >
              <CartesianGrid strokeDasharray="3 3" stroke="rgba(255, 255, 255, 0.1)" />
              <XAxis 
                dataKey="year" 
                stroke="rgba(255, 255, 255, 0.8)"
                tick={{ fill: 'rgba(255, 255, 255, 0.8)' }}
              >
                <Label 
                  value="Years After Death" 
                  position="bottom" 
                  offset={0}
                  style={{ 
                    fontFamily: 'Inter, sans-serif',
                    fill: 'rgba(255, 255, 255, 0.8)',
                    fontSize: 14
                  }}
                />
              </XAxis>
              <YAxis 
                domain={[0, 100]}
                stroke="rgba(255, 255, 255, 0.8)"
                tick={{ fill: 'rgba(255, 255, 255, 0.8)' }}
              >
                <Label
                  value="Percentage (%)"
                  angle={-90}
                  position="left"
                  style={{ 
                    fontFamily: 'Inter, sans-serif',
                    fill: 'rgba(255, 255, 255, 0.8)',
                    fontSize: 14
                  }}
                />
              </YAxis>
              <Tooltip
                contentStyle={{
                  backgroundColor: '#fff',
                  border: 'none',
                  borderRadius: '4px',
                  padding: '10px'
                }}
                formatter={(value) => [`${value}%`]}
              />
              <Legend 
                verticalAlign="top" 
                height={36}
              />
              <Line
                type="monotone"
                dataKey="joel"
                name="Joel"
                stroke={colors.primary}
                strokeWidth={3}
                dot={false}
                activeDot={{ r: 8 }}
              />
              <Line
                type="monotone"
                dataKey="menachem"
                name="Menachem"
                stroke={colors.secondary}
                strokeWidth={3}
                dot={false}
                activeDot={{ r: 8 }}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
        <div className="text-center text-xs mt-4" style={{ color: 'rgba(255, 255, 255, 0.8)' }}>
          Prepared by DataSense © 2024
        </div>
      </CardContent>
    </Card>
  );
};

export default NamingTrendsChart;
