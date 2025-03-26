import { useState, useEffect } from 'react';
import './StatsModal.css';

function StatsModal({ isOpen, onClose }) {
  const [activeTab, setActiveTab] = useState('trends');

  useEffect(() => {
    const handleEscape = (e) => {
      if (e.key === 'Escape') onClose();
    };
    
    if (isOpen) {
      document.addEventListener('keydown', handleEscape);
    }
    
    return () => {
      document.removeEventListener('keydown', handleEscape);
    };
  }, [isOpen, onClose]);

  if (!isOpen) return null;

  // Mock data for demonstration purposes
  const trendData = [
    { year: 2018, social: 35, dark: 25, crypto: 15, employment: 25 },
    { year: 2019, social: 40, dark: 27, crypto: 18, employment: 15 },
    { year: 2020, social: 48, dark: 24, crypto: 22, employment: 6 },
    { year: 2021, social: 45, dark: 20, crypto: 30, employment: 5 },
    { year: 2022, social: 42, dark: 18, crypto: 35, employment: 5 },
    { year: 2023, social: 38, dark: 16, crypto: 42, employment: 4 }
  ];

  const victimData = {
    age: { "Under 18": 25, "18-24": 35, "25-34": 28, "35-44": 8, "45+": 4 },
    gender: { "Female": 65, "Male": 23, "Non-binary": 2, "Unknown": 10 },
    recruitment: { "Social Media": 46, "Job Offers": 29, "Personal Contact": 18, "Other": 7 }
  };

  const renderVictimChart = (data, title) => {
    const total = Object.values(data).reduce((sum, value) => sum + value, 0);
    
    return (
      <div className="victim-chart">
        <h4>{title}</h4>
        <div className="bar-chart">
          {Object.entries(data).map(([key, value]) => (
            <div className="bar-container" key={key}>
              <div className="bar-label">{key}</div>
              <div className="bar-wrapper">
                <div 
                  className="bar" 
                  style={{ width: `${(value / total) * 100}%` }}
                >
                  {Math.round((value / total) * 100)}%
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  };

  const renderTrendChart = () => {
    const years = trendData.map(d => d.year);
    const maxYear = Math.max(...years);
    const minYear = Math.min(...years);
    
    // SVG dimensions
    const svgWidth = 600;
    const svgHeight = 300;
    const padding = { top: 20, right: 30, bottom: 40, left: 50 };
    const chartWidth = svgWidth - padding.left - padding.right;
    const chartHeight = svgHeight - padding.top - padding.bottom;
    
    // Scales
    const xScale = (year) => {
      return padding.left + (year - minYear) / (maxYear - minYear) * chartWidth;
    };
    
    const yScale = (value) => {
      return padding.top + (1 - value / 100) * chartHeight;
    };
    
    // Generate path commands for each trend line
    const generatePath = (key) => {
      return `M ${trendData.map(d => {
        return `${xScale(d.year)} ${yScale(d[key])}`;
      }).join(" L ")}`;
    };
    
    const lineColors = {
      social: "#4285F4",
      dark: "#DB4437",
      crypto: "#F4B400",
      employment: "#0F9D58"
    };
    
    return (
      <div className="trend-chart-container">
        <h3>Trafficking Methods (2018-2023)</h3>
        <div className="chart-legend">
          <div className="legend-item"><span style={{ backgroundColor: lineColors.social }}></span>Social Media</div>
          <div className="legend-item"><span style={{ backgroundColor: lineColors.dark }}></span>Dark Web</div>
          <div className="legend-item"><span style={{ backgroundColor: lineColors.crypto }}></span>Cryptocurrency</div>
          <div className="legend-item"><span style={{ backgroundColor: lineColors.employment }}></span>Fake Employment</div>
        </div>
        <svg width={svgWidth} height={svgHeight} className="trend-chart">
          {/* Y axis */}
          <line 
            x1={padding.left} 
            y1={padding.top} 
            x2={padding.left} 
            y2={svgHeight - padding.bottom} 
            stroke="#ccc" 
          />
          
          {/* X axis */}
          <line 
            x1={padding.left} 
            y1={svgHeight - padding.bottom} 
            x2={svgWidth - padding.right} 
            y2={svgHeight - padding.bottom} 
            stroke="#ccc" 
          />
          
          {/* Y axis labels */}
          {[0, 25, 50, 75, 100].map(value => (
            <g key={`y-${value}`}>
              <text 
                x={padding.left - 10} 
                y={yScale(value)} 
                textAnchor="end" 
                dominantBaseline="middle"
                fontSize="12"
                fill="#666"
              >
                {value}%
              </text>
              <line 
                x1={padding.left} 
                y1={yScale(value)} 
                x2={svgWidth - padding.right} 
                y2={yScale(value)} 
                stroke="#eee" 
                strokeDasharray="5,5"
              />
            </g>
          ))}
          
          {/* X axis labels (years) */}
          {trendData.map(d => (
            <text 
              key={`x-${d.year}`}
              x={xScale(d.year)} 
              y={svgHeight - padding.bottom + 20} 
              textAnchor="middle"
              fontSize="12"
              fill="#666"
            >
              {d.year}
            </text>
          ))}
          
          {/* Plot lines */}
          <path d={generatePath('social')} stroke={lineColors.social} strokeWidth="2" fill="none" />
          <path d={generatePath('dark')} stroke={lineColors.dark} strokeWidth="2" fill="none" />
          <path d={generatePath('crypto')} stroke={lineColors.crypto} strokeWidth="2" fill="none" />
          <path d={generatePath('employment')} stroke={lineColors.employment} strokeWidth="2" fill="none" />
          
          {/* Data points */}
          {trendData.map(d => (
            <g key={`points-${d.year}`}>
              <circle cx={xScale(d.year)} cy={yScale(d.social)} r="4" fill={lineColors.social} />
              <circle cx={xScale(d.year)} cy={yScale(d.dark)} r="4" fill={lineColors.dark} />
              <circle cx={xScale(d.year)} cy={yScale(d.crypto)} r="4" fill={lineColors.crypto} />
              <circle cx={xScale(d.year)} cy={yScale(d.employment)} r="4" fill={lineColors.employment} />
            </g>
          ))}
        </svg>
      </div>
    );
  };

  const renderInsights = () => {
    return (
      <div className="insights-container">
        <h3>Key Insights from AI Monitoring</h3>
        
        <div className="insight-card">
          <h4>Emerging Tactics</h4>
          <ul>
            <li><strong>Cryptocurrency transactions</strong> have increased by 180% since 2018, becoming the preferred method for payments in trafficking operations.</li>
            <li><strong>Private messaging apps</strong> are increasingly used over public social media platforms for recruitment, making detection more difficult.</li>
            <li><strong>Multiple transfers</strong> between digital platforms are being used to obscure recruitment trails.</li>
          </ul>
        </div>
        
        <div className="insight-card">
          <h4>High-Risk Indicators</h4>
          <ul>
            <li>Job offers with pay rates <strong>8-10x higher</strong> than local averages for unskilled work.</li>
            <li>Initial contact to travel proposal timeframe averaging <strong>just 10 days</strong>.</li>
            <li>Significant increase in <strong>cryptocurrency wallet clustering</strong> related to suspicious job postings.</li>
          </ul>
        </div>
        
        <div className="insight-card">
          <h4>AI Detection Impact</h4>
          <ul>
            <li>Pattern recognition algorithms have identified <strong>37 new code phrases</strong> used by traffickers in the past year.</li>
            <li>Social media monitoring has led to <strong>242 early interventions</strong> with potential victims.</li>
            <li>Chatbot interactions have connected <strong>1,890 individuals</strong> with local support resources.</li>
          </ul>
        </div>
      </div>
    );
  };

  return (
    <div className="modal-overlay">
      <div className="stats-modal">
        <div className="modal-header">
          <h2>Anti-Trafficking Analytics Dashboard</h2>
          <button className="close-button" onClick={onClose}>×</button>
        </div>
        
        <div className="modal-tabs">
          <button 
            className={`tab-button ${activeTab === 'trends' ? 'active' : ''}`}
            onClick={() => setActiveTab('trends')}
          >
            Trafficking Trends
          </button>
          <button 
            className={`tab-button ${activeTab === 'victims' ? 'active' : ''}`}
            onClick={() => setActiveTab('victims')}
          >
            Victim Demographics
          </button>
          <button 
            className={`tab-button ${activeTab === 'insights' ? 'active' : ''}`}
            onClick={() => setActiveTab('insights')}
          >
            AI Insights
          </button>
        </div>
        
        <div className="modal-content">
          {activeTab === 'trends' && renderTrendChart()}
          
          {activeTab === 'victims' && (
            <div className="victims-container">
              {renderVictimChart(victimData.age, 'Age Distribution')}
              {renderVictimChart(victimData.gender, 'Gender Distribution')}
              {renderVictimChart(victimData.recruitment, 'Recruitment Methods')}
            </div>
          )}
          
          {activeTab === 'insights' && renderInsights()}
        </div>
        
        <div className="modal-footer">
          <p><em>Note: This is simulated data for demonstration purposes only</em></p>
        </div>
      </div>
    </div>
  );
}

export default StatsModal;
