#!/bin/bash

echo "Setting up Anti-Trafficking Chatbot Demo"
echo "========================================"

# Create project directory structure
mkdir -p anti-trafficking-chatbot/src
mkdir -p .devcontainer

# Create package.json
cat > anti-trafficking-chatbot/package.json << 'EOL'
{
  "name": "anti-trafficking-chatbot",
  "private": true,
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "lint": "eslint . --ext js,jsx --report-unused-disable-directives --max-warnings 0",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.15",
    "@types/react-dom": "^18.2.7",
    "@vitejs/plugin-react": "^4.0.3",
    "eslint": "^8.45.0",
    "eslint-plugin-react": "^7.32.2",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.3",
    "vite": "^4.4.5"
  }
}
EOL

# Create vite.config.js
cat > anti-trafficking-chatbot/vite.config.js << 'EOL'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
})
EOL

# Create index.html
cat > anti-trafficking-chatbot/index.html << 'EOL'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Anti-Trafficking Chatbot | IRC Demo</title>
    <meta name="description" content="A prototype chatbot for the International Rescue Committee to combat human trafficking">
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOL

# Create .devcontainer/devcontainer.json
cat > .devcontainer/devcontainer.json << 'EOL'
{
  "name": "Anti-Trafficking Chatbot",
  "image": "mcr.microsoft.com/devcontainers/javascript-node:0-18",
  "forwardPorts": [5173],
  "postCreateCommand": "cd anti-trafficking-chatbot && npm install",
  "customizations": {
    "vscode": {
      "extensions": [
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode",
        "formulahendry.auto-rename-tag"
      ]
    }
  }
}
EOL

# Create React files
echo "Creating React component files..."

# Create main.jsx
cat > anti-trafficking-chatbot/src/main.jsx << 'EOL'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
EOL

# Create index.css
cat > anti-trafficking-chatbot/src/index.css << 'EOL'
body {
  margin: 0;
  padding: 0;
  min-height: 100vh;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

#root {
  min-height: 100vh;
}
EOL

# Create App.css
cat > anti-trafficking-chatbot/src/App.css << 'EOL'
:root {
  --primary-color: #1a73e8;
  --secondary-color: #f1f3f4;
  --bot-message-bg: var(--secondary-color);
  --user-message-bg: var(--primary-color);
  --user-message-color: white;
  --border-radius: 18px;
  --text-color: #202124;
  --light-text-color: #5f6368;
}

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  line-height: 1.6;
  color: var(--text-color);
  background-color: #f9f9f9;
}

.app-container {
  max-width: 800px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  height: 100vh;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  background-color: white;
}

.app-header {
  padding: 20px;
  background-color: var(--primary-color);
  color: white;
  text-align: center;
}

.app-header h1 {
  margin-bottom: 5px;
  font-size: 1.5rem;
}

.app-header p {
  font-size: 0.9rem;
  opacity: 0.9;
}

.stats-button {
  position: absolute;
  top: 20px;
  right: 20px;
  background-color: white;
  color: var(--primary-color);
  border: none;
  padding: 8px 15px;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.stats-button:hover {
  background-color: #f1f1f1;
  box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
}

.chat-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.messages-container {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.message {
  max-width: 80%;
  padding: 10px 15px;
  border-radius: var(--border-radius);
  position: relative;
  word-wrap: break-word;
}

.user-message {
  background-color: var(--user-message-bg);
  color: var(--user-message-color);
  align-self: flex-end;
  border-bottom-right-radius: 5px;
}

.bot-message {
  background-color: var(--bot-message-bg);
  align-self: flex-start;
  border-bottom-left-radius: 5px;
}

.message-content {
  font-size: 0.95rem;
}

.message-content strong {
  font-weight: 600;
}

.input-container {
  display: flex;
  padding: 15px;
  background-color: white;
  border-top: 1px solid #e0e0e0;
}

.input-container input {
  flex: 1;
  padding: 12px 15px;
  border: 1px solid #e0e0e0;
  border-radius: 20px;
  font-size: 0.95rem;
  outline: none;
  transition: border-color 0.2s;
}

.input-container input:focus {
  border-color: var(--primary-color);
}

.input-container button {
  margin-left: 10px;
  padding: 0 20px;
  background-color: var(--primary-color);
  color: white;
  border: none;
  border-radius: 20px;
  cursor: pointer;
  font-weight: 500;
  transition: background-color 0.2s;
}

.input-container button:hover {
  background-color: #0d62d0;
}

.input-container button:disabled {
  background-color: #a9c9fa;
  cursor: not-allowed;
}

.app-footer {
  padding: 15px;
  background-color: white;
  border-top: 1px solid #e0e0e0;
}

.app-footer p {
  font-size: 0.9rem;
  color: var(--light-text-color);
  margin-bottom: 10px;
}

.suggestion-chips {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.suggestion-chips button {
  background-color: var(--secondary-color);
  border: none;
  padding: 8px 15px;
  border-radius: 20px;
  font-size: 0.85rem;
  cursor: pointer;
  transition: background-color 0.2s;
  color: var(--primary-color);
}

.suggestion-chips button:hover {
  background-color: #e0e0e0;
}

.demo-mode-container {
  display: flex;
  justify-content: center;
  margin-top: 15px;
}

.demo-button {
  background-color: var(--primary-color);
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 20px;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.2s;
}

.demo-button:hover {
  background-color: #0d62d0;
}

.demo-button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.demo-running {
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0.7;
  }
  100% {
    opacity: 1;
  }
}

.typing-indicator {
  display: flex;
  gap: 5px;
  padding: 5px;
}

.typing-indicator span {
  width: 8px;
  height: 8px;
  background-color: var(--light-text-color);
  border-radius: 50%;
  display: inline-block;
  opacity: 0.7;
  animation: typing 1s infinite ease-in-out;
}

.typing-indicator span:nth-child(1) {
  animation-delay: 0s;
}

.typing-indicator span:nth-child(2) {
  animation-delay: 0.2s;
}

.typing-indicator span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes typing {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-5px);
  }
}

/* Media queries for responsiveness */
@media (max-width: 600px) {
  .app-container {
    height: 100%;
    width: 100%;
  }
  
  .message {
    max-width: 90%;
  }
}
EOL

# Create StatsModal.css
cat > anti-trafficking-chatbot/src/StatsModal.css << 'EOL'
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.stats-modal {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
  width: 90%;
  max-width: 800px;
  max-height: 90vh;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 20px;
  border-bottom: 1px solid #e0e0e0;
}

.modal-header h2 {
  margin: 0;
  font-size: 1.5rem;
  color: var(--primary-color);
}

.close-button {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #666;
}

.modal-tabs {
  display: flex;
  border-bottom: 1px solid #e0e0e0;
}

.tab-button {
  padding: 12px 20px;
  background: none;
  border: none;
  border-bottom: 3px solid transparent;
  cursor: pointer;
  font-weight: 500;
  color: #666;
  transition: all 0.2s;
}

.tab-button:hover {
  background-color: #f5f5f5;
}

.tab-button.active {
  color: var(--primary-color);
  border-bottom-color: var(--primary-color);
}

.modal-content {
  padding: 20px;
  overflow-y: auto;
  flex: 1;
}

.modal-footer {
  padding: 10px 20px;
  border-top: 1px solid #e0e0e0;
  font-size: 0.8rem;
  color: #999;
  text-align: center;
}

/* Trend Chart Styles */
.trend-chart-container {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.trend-chart-container h3 {
  margin-bottom: 15px;
  text-align: center;
}

.chart-legend {
  display: flex;
  justify-content: center;
  margin-bottom: 15px;
  flex-wrap: wrap;
}

.legend-item {
  display: flex;
  align-items: center;
  margin: 0 10px;
  font-size: 0.9rem;
}

.legend-item span {
  display: inline-block;
  width: 15px;
  height: 15px;
  margin-right: 5px;
  border-radius: 3px;
}

/* Victim Demographics Styles */
.victims-container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
}

.victim-chart {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 15px;
  background-color: #f9f9f9;
}

.victim-chart h4 {
  margin-top: 0;
  margin-bottom: 15px;
  text-align: center;
  color: #444;
}

.bar-chart {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.bar-container {
  display: flex;
  align-items: center;
}

.bar-label {
  width: 100px;
  font-size: 0.85rem;
  color: #555;
}

.bar-wrapper {
  flex: 1;
  background-color: #e0e0e0;
  height: 20px;
  border-radius: 10px;
  overflow: hidden;
}

.bar {
  height: 100%;
  background-color: var(--primary-color);
  color: white;
  font-size: 0.8rem;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding-right: 8px;
  min-width: 30px;
  transition: width 0.5s ease-out;
}

/* Insights Styles */
.insights-container {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.insights-container h3 {
  text-align: center;
  margin-bottom: 10px;
}

.insight-card {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 15px;
  background-color: #f9f9f9;
}

.insight-card h4 {
  margin-top: 0;
  margin-bottom: 10px;
  color: var(--primary-color);
  border-bottom: 1px solid #e0e0e0;
  padding-bottom: 8px;
}

.insight-card ul {
  margin: 0;
  padding-left: 20px;
}

.insight-card li {
  margin-bottom: 8px;
  line-height: 1.4;
}

/* Responsive adjustments */
@media (max-width: 700px) {
  .modal-tabs {
    flex-direction: column;
  }
  
  .tab-button.active {
    border-bottom: none;
    border-left: 3px solid var(--primary-color);
  }
  
  .victims-container {
    grid-template-columns: 1fr;
  }
  
  .trend-chart-container svg {
    width: 100%;
    height: auto;
  }
}
EOL

# Create the StatsModal.jsx component
cat > anti-trafficking-chatbot/src/StatsModal.jsx << 'EOL'
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
EOL

# Create the main App.jsx component
cat > anti-trafficking-chatbot/src/App.jsx << 'EOL'
import { useState, useRef, useEffect } from 'react'
import './App.css'
import StatsModal from './StatsModal'

// Knowledge base about trafficking tactics and responses
const knowledgeBase = {
  aiTools: [
    {
      name: "Social Media Monitoring",
      description: "AI systems that analyze patterns across social media platforms to identify potential trafficking networks.",
      capabilities: [
        "Identify suspicious patterns in post frequency and timing", 
        "Detect known code words or euphemisms used by traffickers",
        "Recognize image manipulation used to hide identities",
        "Map connection networks between suspicious accounts"
      ],
      examples: [
        "The IRC's monitoring system identified a 320% increase in job recruitment posts for specific regions following conflict events",
        "Automated linguistic analysis detected new coded terminology being used for exploitation",
        "Pattern recognition flagged unusual money transfer requests between seemingly unrelated accounts"
      ]
    },
    {
      name: "Chatbot Prevention Tools",
      description: "Interactive AI assistants designed to educate vulnerable populations and provide resources.",
      capabilities: [
        "Provide 24/7 access to anti-trafficking information in multiple languages", 
        "Respond to specific questions about warning signs and reporting options",
        "Connect users with local resources appropriate to their situation",
        "Collect anonymized data on common concerns to inform prevention efforts"
      ],
      examples: [
        "Deployment in refugee camps reduced reported trafficking incidents by 28%",
        "Integration with messaging platforms increased resource access for at-risk youth",
        "Multilingual support enabled outreach to previously underserved populations"
      ]
    },
    {
      name: "Predictive Analytics",
      description: "AI systems that identify high-risk patterns and predict potential trafficking hotspots.",
      capabilities: [
        "Analyze economic, conflict, and migration data to identify vulnerable communities", 
        "Detect unusual travel patterns correlated with known trafficking routes",
        "Monitor cryptocurrency transactions for suspicious payment patterns",
        "Identify correlations between online recruitment and offline exploitation"
      ],
      examples: [
        "System predicted 7 of 9 major trafficking operations based on border crossing patterns",
        "Financial pattern analysis led to identification of three major trafficking networks",
        "Regional risk forecasting allowed preventative education deployments that reached 15,000 at-risk individuals"
      ]
    },
    {
      name: "Generative AI Content Creation",
      description: "Using AI to create targeted educational and awareness content across cultures and languages.",
      capabilities: [
        "Generate culturally appropriate awareness materials in multiple languages", 
        "Create customized educational content for specific vulnerable groups",
        "Produce realistic scenarios for training first responders",
        "Adapt prevention messages to evolving trafficking tactics"
      ],
      examples: [
        "AI-generated videos in 12 languages reached 3M+ people with trafficking awareness content",
        "Custom scenarios improved law enforcement identification of victims by 46%",
        "Adaptive content generation responded to new crypto-based trafficking methods within days of detection"
      ]
    }
  ],
  tactics: [
    {
      name: "Social Media Recruitment",
      description: "Traffickers use social media to identify and groom potential victims with false promises of relationships, jobs, or opportunities.",
      indicators: [
        "Job offers that seem too good to be true", 
        "Romantic interest from strangers who quickly want to meet in person",
        "Requests to move conversations to private platforms",
        "Pressure to travel quickly for opportunities"
      ],
      countermeasures: [
        "Verify job offers through official channels",
        "Research companies and opportunities thoroughly",
        "Be cautious about sharing personal information online",
        "Meet new contacts only in public places"
      ]
    },
    {
      name: "Dark Web Marketplaces",
      description: "Traffickers use encrypted platforms to advertise and sell victims' services, often using coded language.",
      indicators: [
        "Coded advertisements for 'services'", 
        "Dehumanizing language about individuals",
        "Time-limited 'special offers'",
        "Location-specific advertisements that change frequently"
      ],
      countermeasures: [
        "Monitor patterns in online advertisements",
        "Use NLP to identify coded language",
        "Track location patterns in advertisements",
        "Collaborate with law enforcement on monitoring"
      ]
    },
    {
      name: "Cryptocurrency Transactions",
      description: "Traffickers use cryptocurrency to receive payments anonymously and obscure financial trails.",
      indicators: [
        "Untraceable payment methods", 
        "Multiple wallet transfers to hide origins",
        "Patterns of payments at specific times",
        "Correlation between payments and movement of people"
      ],
      countermeasures: [
        "Blockchain analysis to identify suspicious patterns",
        "Partner with cryptocurrency exchanges for monitoring",
        "Create financial intelligence units",
        "Track correlations between payments and other activities"
      ]
    },
    {
      name: "Fake Employment Agencies",
      description: "Online 'agencies' that promise overseas employment but are fronts for trafficking operations.",
      indicators: [
        "Requirements for large upfront fees", 
        "Limited or no online presence beyond recruitment ads",
        "Vague job descriptions with promises of high pay",
        "Requests for passport or identity documents before hire"
      ],
      countermeasures: [
        "Verify agency credentials with official sources",
        "Create databases of legitimate vs suspicious agencies",
        "Develop warning systems for common recruitment regions",
        "Educate about legitimate employment processes"
      ]
    }
  ],
  resources: [
    {
      name: "National Human Trafficking Hotline",
      contact: "1-888-373-7888",
      description: "24/7 confidential helpline for reporting tips and connecting with anti-trafficking services."
    },
    {
      name: "International Criminal Police Organization (INTERPOL)",
      contact: "www.interpol.int",
      description: "Global coordination for trafficking investigations across borders."
    },
    {
      name: "United Nations Office on Drugs and Crime",
      contact: "www.unodc.org/unodc/en/human-trafficking/",
      description: "International resources and coordination for trafficking prevention."
    },
    {
      name: "Polaris Project",
      contact: "polarisproject.org",
      description: "U.S.-based organization working to combat and prevent trafficking."
    }
  ],
  responses: {
    greeting: [
      "Hello, I'm an anti-trafficking information assistant. How can I help you today?",
      "Welcome. I can provide information about human trafficking tactics, warning signs, and resources. What would you like to know?",
      "Hi there. I'm here to help with information about preventing human trafficking. What information are you looking for?"
    ],
    unknown: [
      "I don't have information about that yet. Would you like to know about trafficking tactics, warning signs, or resources instead?",
      "I'm not sure I understand. Could you try asking about trafficking methods, how to stay safe, or where to report suspicious activity?",
      "I don't have data on that. I can tell you about common trafficking tactics, warning signs to watch for, or resources for help."
    ],
    farewell: [
      "Stay safe. Remember to contact authorities if you suspect trafficking activity.",
      "Thank you for using this resource. If you need more information, don't hesitate to return.",
      "Remember, awareness is the first step in prevention. Take care and stay vigilant."
    ]
  }
};

// Simple pattern matching for user intents
const patterns = {
  tactics: /tactic|method|approach|strategy|how.*(traffic|exploit)/i,
  warning: /warning|sign|indicator|recognize|identify/i,
  report: /report|help|resource|hotline|contact|assistance/i,
  social_media: /social|facebook|instagram|tiktok|snapchat|online/i,
  dark_web: /dark web|darknet|encrypted|hidden|tor/i,
  cryptocurrency: /crypto|bitcoin|payment|money|transaction/i,
  employment: /job|work|employment|opportunity|career|agency/i,
  ai_tools: /ai|artificial intelligence|machine learning|tool|technology|system|digital|tech/i,
  monitoring: /monitor|track|surveillance|detect|scan|observe/i,
  prediction: /predict|forecast|anticipate|analyze|pattern|trend/i,
  chatbot: /chatbot|assistant|bot|automated|interactive/i,
  content: /content|video|material|education|generate|create/i,
  statistics: /stat|number|data|percent|frequency/i,
  greeting: /hello|hi|hey|greetings|start/i,
  farewell: /bye|goodbye|exit|quit|end/i
};

// AI model simulation for generating answers
const generateResponse = (message) => {
  const lowerMsg = message.toLowerCase();
  
  // Check for greetings
  if (patterns.greeting.test(lowerMsg)) {
    return randomChoice(knowledgeBase.responses.greeting);
  }
  
  // Check for farewells
  if (patterns.farewell.test(lowerMsg)) {
    return randomChoice(knowledgeBase.responses.farewell);
  }
  
  // Check for questions about AI tools
  if (patterns.ai_tools.test(lowerMsg)) {
    // Check for specific AI tools mentioned
    let specificTools = [];
    
    if (patterns.monitoring.test(lowerMsg)) {
      specificTools.push(knowledgeBase.aiTools.find(t => t.name === "Social Media Monitoring"));
    }
    
    if (patterns.chatbot.test(lowerMsg)) {
      specificTools.push(knowledgeBase.aiTools.find(t => t.name === "Chatbot Prevention Tools"));
    }
    
    if (patterns.prediction.test(lowerMsg)) {
      specificTools.push(knowledgeBase.aiTools.find(t => t.name === "Predictive Analytics"));
    }
    
    if (patterns.content.test(lowerMsg)) {
      specificTools.push(knowledgeBase.aiTools.find(t => t.name === "Generative AI Content Creation"));
    }
    
    // If no specific tools were mentioned, or if asking about AI tools generally
    if (specificTools.length === 0) {
      let response = "AI technologies can be powerful tools in combating human trafficking. Here are some key approaches:\n\n";
      
      knowledgeBase.aiTools.forEach(tool => {
        response += `**${tool.name}**: ${tool.description}\n`;
      });
      
      response += "\nYou can ask me about any specific AI approach for more details.";
      return response;
    } else {
      // Return information about specific AI tools
      let response = "";
      
      if (specificTools.length === 1) {
        response = `Here's how ${specificTools[0].name} can help combat trafficking:\n\n`;
      } else {
        response = "Here's information about these AI approaches to combat trafficking:\n\n";
      }
      
      specificTools.forEach(tool => {
        response += `**${tool.name}**\n${tool.description}\n\n`;
        
        response += "**Key Capabilities**:\n";
        tool.capabilities.forEach(capability => {
          response += `- ${capability}\n`;
        });
        
        response += "\n**Real-World Examples**:\n";
        tool.examples.forEach(example => {
          response += `- ${example}\n`;
        });
        response += "\n";
      });
      
      return response;
    }
  }
  
  // Check for tactics + specific method
  if (patterns.tactics.test(lowerMsg)) {
    // Check for specific tactics mentioned
    let specificTactics = [];
    
    if (patterns.social_media.test(lowerMsg)) {
      specificTactics.push(knowledgeBase.tactics.find(t => t.name === "Social Media Recruitment"));
    }
    
    if (patterns.dark_web.test(lowerMsg)) {
      specificTactics.push(knowledgeBase.tactics.find(t => t.name === "Dark Web Marketplaces"));
    }
    
    if (patterns.cryptocurrency.test(lowerMsg)) {
      specificTactics.push(knowledgeBase.tactics.find(t => t.name === "Cryptocurrency Transactions"));
    }
    
    if (patterns.employment.test(lowerMsg)) {
      specificTactics.push(knowledgeBase.tactics.find(t => t.name === "Fake Employment Agencies"));
    }
    
    // If specific tactics were found, return information about them
    if (specificTactics.length > 0) {
      let response = "Here's what I know about these trafficking tactics:\n\n";
      
      specificTactics.forEach(tactic => {
        response += `**${tactic.name}**: ${tactic.description}\n\n`;
        response += "**Warning Signs**:\n";
        tactic.indicators.forEach(indicator => {
          response += `- ${indicator}\n`;
        });
        
        response += "\n**Prevention Strategies**:\n";
        tactic.countermeasures.forEach(measure => {
          response += `- ${measure}\n`;
        });
        response += "\n";
      });
      
      return response;
    } else {
      // Return general tactics information
      let response = "Traffickers use various methods online. Here are some common tactics:\n\n";
      
      knowledgeBase.tactics.forEach(tactic => {
        response += `**${tactic.name}**: ${tactic.description}\n`;
      });
      
      response += "\nAsk me about a specific tactic for more details.";
      return response;
    }
  }
  
  // Check for warning signs
  if (patterns.warning.test(lowerMsg)) {
    let response = "Here are warning signs of potential trafficking situations:\n\n";
    
    knowledgeBase.tactics.forEach(tactic => {
      response += `**${tactic.name}**:\n`;
      tactic.indicators.forEach(indicator => {
        response += `- ${indicator}\n`;
      });
      response += "\n";
    });
    
    return response;
  }
  
  // Check for reporting and resources
  if (patterns.report.test(lowerMsg)) {
    let response = "If you suspect trafficking activity, here are resources that can help:\n\n";
    
    knowledgeBase.resources.forEach(resource => {
      response += `**${resource.name}**\n`;
      response += `Contact: ${resource.contact}\n`;
      response += `${resource.description}\n\n`;
    });
    
    response += "Remember, if someone is in immediate danger, contact local emergency services immediately.";
    return response;
  }
  
  // If no specific intent matched
  return randomChoice(knowledgeBase.responses.unknown);
};

// Helper function to select a random item from an array
const randomChoice = (array) => {
  return array[Math.floor(Math.random() * array.length)];
};

// Helper function to format markdown-like syntax
const formatMessage = (text) => {
  // Bold text
  let formatted = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
  
  // Convert line breaks to HTML
  formatted = formatted.replace(/\n/g, '<br>');
  
  return formatted;
};

function App() {
  const [input, setInput] = useState('');
  const [messages, setMessages] = useState([
    { 
      sender: 'bot', 
      text: "Hello, I'm an anti-trafficking information assistant developed for the International Rescue Committee. I can provide information about trafficking tactics, warning signs, and resources. How can I help you today?" 
    }
  ]);
  const [isTyping, setIsTyping] = useState(false);
  const [demoMode, setDemoMode] = useState(false);
  const [showStats, setShowStats] = useState(false);
  const messagesEndRef = useRef(null);
  const demoTimeoutRef = useRef(null);

  // Auto-scroll to bottom of messages
  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  const handleSend = () => {
    if (input.trim() === '') return;
    
// Add user message
    setMessages([...messages, { sender: 'user', text: input }]);
    setInput('');
    setIsTyping(true);
    
    // Simulate AI processing delay
    setTimeout(() => {
      const response = generateResponse(input);
      setMessages(prev => [...prev, { sender: 'bot', text: response }]);
      setIsTyping(false);
    }, 1000);
  };

  const handleKeyDown = (e) => {
    if (e.key === 'Enter') {
      handleSend();
    }
  };
  
  // Demo mode sequence
  const startDemoMode = () => {
    if (demoMode) return; // Don't start if already running
    
    setDemoMode(true);
    setMessages([
      { 
        sender: 'bot', 
        text: "Starting demo mode. I'll show you some sample interactions..." 
      }
    ]);
    
    // Demo sequence of questions and answers
    const demoSequence = [
      "What tactics do traffickers use on social media?",
      "What warning signs should I look for?",
      "How do traffickers use cryptocurrency?",
      "Where can I report suspicious activity?",
      "How can AI help combat human trafficking?"
    ];
    
    let currentStep = 0;
    
    const runNextStep = () => {
      if (currentStep >= demoSequence.length) {
        setDemoMode(false);
        setMessages(prev => [...prev, { 
          sender: 'bot', 
          text: "Demo completed. You can now ask your own questions!" 
        }]);
        return;
      }
      
      const question = demoSequence[currentStep];
      setMessages(prev => [...prev, { sender: 'user', text: question }]);
      
      setTimeout(() => {
        setIsTyping(true);
        
        setTimeout(() => {
          const response = generateResponse(question);
          setMessages(prev => [...prev, { sender: 'bot', text: response }]);
          setIsTyping(false);
          currentStep++;
          
          demoTimeoutRef.current = setTimeout(runNextStep, 5000);
        }, 1500);
      }, 1000);
    };
    
    demoTimeoutRef.current = setTimeout(runNextStep, 1500);
  };
  
  // Clean up demo mode timeouts when component unmounts
  useEffect(() => {
    return () => {
      if (demoTimeoutRef.current) {
        clearTimeout(demoTimeoutRef.current);
      }
    };
  }, []);

  return (
    <div className="app-container">
      <header className="app-header">
        <h1>Anti-Trafficking Information Assistant</h1>
        <p>A prototype for the International Rescue Committee</p>
        <button className="stats-button" onClick={() => setShowStats(true)}>
          View Analytics Dashboard
        </button>
      </header>
      
      <div className="chat-container">
        <div className="messages-container">
          {messages.map((message, index) => (
            <div 
              key={index} 
              className={`message ${message.sender === 'user' ? 'user-message' : 'bot-message'}`}
            >
              <div 
                className="message-content"
                dangerouslySetInnerHTML={{ __html: formatMessage(message.text) }}
              />
            </div>
          ))}
          {isTyping && (
            <div className="message bot-message">
              <div className="typing-indicator">
                <span></span>
                <span></span>
                <span></span>
              </div>
            </div>
          )}
          <div ref={messagesEndRef} />
        </div>
        
        <div className="input-container">
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyDown={handleKeyDown}
            placeholder="Ask about trafficking tactics, warning signs, or resources..."
            disabled={isTyping}
          />
          <button onClick={handleSend} disabled={isTyping}>Send</button>
        </div>
      </div>
      
      <footer className="app-footer">
        <p>Suggested questions:</p>
        <div className="suggestion-chips">
          <button onClick={() => setInput("What tactics do traffickers use on social media?")}>
            Social media tactics
          </button>
          <button onClick={() => setInput("How can I recognize warning signs of trafficking?")}>
            Warning signs
          </button>
          <button onClick={() => setInput("Where can I report suspicious activity?")}>
            Reporting resources
          </button>
          <button onClick={() => setInput("How do traffickers use cryptocurrency?")}>
            Cryptocurrency methods
          </button>
          <button onClick={() => setInput("How can AI help combat human trafficking?")}>
            AI solutions
          </button>
          <button onClick={() => setInput("Tell me about AI monitoring systems")}>
            AI monitoring
          </button>
        </div>
        <div className="demo-mode-container">
          <button 
            className={`demo-button ${demoMode ? 'demo-running' : ''}`}
            onClick={startDemoMode}
            disabled={demoMode}
          >
            {demoMode ? 'Demo Running...' : 'Start Demo Mode'}
          </button>
        </div>
      </footer>
      
      {/* Statistics Modal */}
      <StatsModal 
        isOpen={showStats} 
        onClose={() => setShowStats(false)} 
      />
    </div>
  );
}

export default App
EOL

# Create README.md
cat > anti-trafficking-chatbot/README.md << 'EOL'
# Anti-Trafficking Chatbot Demo

This is a prototype chatbot for the International Rescue Committee to demonstrate how AI and technology can be used to combat human trafficking.

## Features

- Information on common trafficking tactics
- Warning signs to identify potential trafficking situations
- Resources for reporting and getting help
- Simple natural language processing for user queries
- Responsive design for mobile and desktop use
- Visualization of trafficking data trends
- Demo of AI capabilities for trafficking prevention

## Running the Demo

1. Open this project in GitHub Codespaces or clone it to your local machine.

2. Install dependencies:
   ```
   cd anti-trafficking-chatbot
   npm install
   ```

3. Start the development server:
   ```
   npm run dev
   ```

4. Open your browser to the URL shown in the terminal (usually http://localhost:5173)

## Sample Queries

Try asking the chatbot the following questions:

- "What tactics do traffickers use on social media?"
- "How can I recognize warning signs of trafficking?"
- "Where can I report suspicious activity?"
- "Tell me about cryptocurrency and trafficking"
- "What are fake employment agencies?"
- "How can AI help combat human trafficking?"
- "Tell me about AI monitoring systems"

## Technical Overview

This prototype demonstrates:

1. **Knowledge Base Integration**: Structured data on trafficking tactics, warning signs, and resources.
2. **Natural Language Understanding**: Pattern matching to identify user intents.
3. **Responsive UI**: Design that works on both desktop and mobile devices.
4. **Interactive Features**: Suggested queries to guide users.
5. **Data Visualization**: Analytics dashboard showing trafficking trends.
6. **AI Tools Showcase**: Information on how AI can be applied to combat trafficking.

## Next Steps for Development

In a full implementation, this chatbot could be expanded to include:

1. **Full NLP Integration**: Connect to a comprehensive NLP model for better understanding of user queries.
2. **Multi-language Support**: Expand capabilities to support multiple languages.
3. **Content Management System**: Allow updates to the knowledge base without code changes.
4. **User Feedback Loop**: Collect and analyze user interactions to improve responses.
5. **Integration with Reporting Systems**: Direct connections to reporting tools and law enforcement.
6. **Social Media Monitoring**: Add capabilities to monitor and identify trafficking indicators on social platforms.

## Interview Talking Points

When presenting this demo, you can discuss:

1. How this simple prototype could be expanded with more advanced AI capabilities
2. The importance of having domain experts contribute to the knowledge base
3. How this type of tool could be integrated into broader anti-trafficking strategies
4. Privacy and ethical considerations in monitoring and reporting systems
5. The balance between automation and human intervention in trafficking detection and response
EOL

echo "Making setup script executable..."
chmod +x setup.sh

echo "Setting up project completed! To start the demo:"
echo "1. Navigate to the project directory: cd anti-trafficking-chatbot"
echo "2. Install dependencies: npm install"
echo "3. Start the development server: npm run dev"
echo "4. The chatbot will be available at the URL shown in the terminal"
echo ""
echo "Good luck with your interview!"