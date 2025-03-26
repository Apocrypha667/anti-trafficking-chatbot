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
