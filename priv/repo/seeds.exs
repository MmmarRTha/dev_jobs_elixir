# Create a list of job listings
job_listings = [
  %DevJobs.JobListings.JobListing{
    title: "Elixir Backend Developer",
    company: "Tech Solutions",
    location: "Seattle",
    description:
      "Join our dynamic backend team at Tech Solutions! We're seeking an Elixir developer passionate about building highly scalable distributed systems. Key responsibilities include: designing and implementing microservices, optimizing database performance, and collaborating with cross-functional teams. Required skills: 3+ years Elixir/Phoenix, PostgreSQL, and distributed systems experience. We offer competitive benefits, flexible work hours, and a collaborative environment focused on continuous learning.",
    salary: 95000
  },
  %DevJobs.JobListings.JobListing{
    title: "Full Stack Engineer",
    company: "WebTech",
    location: "Austin",
    description:
      "WebTech is expanding our product team! We're looking for a versatile Full Stack Engineer to build modern web applications. You'll work with Elixir/Phoenix LiveView on the backend and modern JavaScript frameworks on the frontend. Key responsibilities: developing new features, improving UI/UX, optimizing application performance, and mentoring junior developers. Required: Strong experience with Elixir/Phoenix LiveView, JavaScript/TypeScript, and modern frontend frameworks (React/Vue). We pride ourselves on work-life balance and offer remote work options, health benefits, and professional development opportunities.",
    salary: 105_000
  },
  %DevJobs.JobListings.JobListing{
    title: "iOS Mobile App Developer",
    company: "AppWorks",
    location: "Los Angeles",
    description:
      "AppWorks is seeking a talented iOS Developer to join our innovative mobile team! You'll be responsible for developing and maintaining cutting-edge iOS applications for our diverse client base. Core responsibilities include: architecting robust mobile solutions, implementing clean, maintainable code, and ensuring app performance and reliability. Required skills: Swift, UIKit/SwiftUI, Core Data, and experience with CI/CD pipelines. We offer competitive salary, stock options, health benefits, and the opportunity to work on diverse, challenging projects that impact millions of users.",
    salary: 95000
  },
  %DevJobs.JobListings.JobListing{
    title: "DevOps Engineer",
    company: "Cloud Solutions",
    location: "Denver",
    description:
      "Join Cloud Solutions as a DevOps Engineer and help shape our cloud infrastructure! We're looking for someone passionate about automation and infrastructure as code. You'll be responsible for: designing and implementing CI/CD pipelines, managing cloud infrastructure on AWS/GCP, monitoring system performance, and implementing security best practices. Required skills: Strong experience with Docker, Kubernetes, Terraform, and major cloud platforms. Knowledge of Python or Go is a plus. We offer flexible work arrangements, comprehensive health coverage, 401(k) matching, and regular team-building events.",
    salary: 100_000
  },
  %DevJobs.JobListings.JobListing{
    title: "UI/UX Designer",
    company: "Design Co.",
    location: "London",
    description:
      "Design Co. is looking for a creative and user-focused UI/UX Designer to join our growing team! You'll be creating beautiful, intuitive interfaces that delight our users. Key responsibilities include: conducting user research, creating wireframes and prototypes, designing responsive interfaces, and collaborating with developers to ensure pixel-perfect implementation. Required skills: Strong portfolio demonstrating web/mobile design work, proficiency in Figma/Sketch, experience with design systems, and knowledge of user research methodologies. We offer a creative work environment, the latest design tools, regular design workshops, and opportunities for professional growth.",
    salary: 90000
  },
  %DevJobs.JobListings.JobListing{
    title: "Machine Learning Engineer",
    company: "AI Solutions",
    location: "Berlin",
    description:
      "AI Solutions is at the forefront of artificial intelligence innovation, and we're seeking a talented Machine Learning Engineer to join our research team! You'll be working on cutting-edge ML projects in computer vision and natural language processing. Key responsibilities: developing and deploying ML models, optimizing model performance, conducting research experiments, and collaborating with data scientists. Required skills: MS/PhD in Computer Science or related field, strong Python programming, experience with PyTorch or TensorFlow, and background in deep learning. We offer: Competitive salary, research publication opportunities, conference attendance support, and state-of-the-art computing resources.",
    salary: 110_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Product Manager",
    company: "Tech Startup",
    location: "San Diego",
    description:
      "Drive the end-to-end product lifecycle for fast-moving initiatives at our growing startup. You will translate customer insights and business goals into clear roadmaps, write detailed requirements, align cross-functional stakeholders, and partner closely with engineering and design to deliver high-impact releases. Success looks like shipping value iteratively, measuring outcomes rigorously, and continuously refining strategy based on data and user feedback.",
    salary: 100_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Quality Assurance Engineer",
    company: "Testing Solutions",
    location: "Toronto",
    description:
      "Own the quality bar across web and backend services by designing comprehensive test plans, building automated test suites (unit, integration, and end-to-end), and implementing robust CI pipelines. You will partner with developers to reproduce tricky defects, prevent regressions, and champion a quality-first culture. Experience with test frameworks, observability tools, and risk-based testing is highly valued.",
    salary: 95000
  },
  %DevJobs.JobListings.JobListing{
    title: "Database Administrator",
    company: "Data Management",
    location: "Sydney",
    description:
      "Administer, secure, and optimize mission-critical PostgreSQL instances at scale. Responsibilities include schema design, query tuning, capacity planning, backup and recovery strategies, and high availability/replication. You will work closely with engineering to evolve data models and ensure reliability, performance, and cost efficiency.",
    salary: 105_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Cybersecurity Analyst",
    company: "Security Solutions",
    location: "Washington D.C.",
    description:
      "Monitor, detect, and respond to security threats across cloud and on-prem environments. You will conduct log analysis, threat hunting, vulnerability assessments, and incident response while continuously improving detections and playbooks. Familiarity with SIEMs, EDR, IAM, and security frameworks (NIST/ISO) is important.",
    salary: 100_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Game Developer",
    company: "Gaming Studios",
    location: "Tokyo",
    description:
      "Build polished gameplay systems, tools, and content pipelines that delight players. Collaborate with designers, artists, and producers to implement features, optimize performance, and iterate rapidly based on player feedback. Experience with game engines, rendering, physics, and asset workflows is a plus.",
    salary: 95000
  },
  %DevJobs.JobListings.JobListing{
    title: "Network Engineer",
    company: "Networking Solutions",
    location: "Paris",
    description:
      "Design, implement, and operate secure, resilient networks across multiple sites and clouds. Responsibilities include routing/switching, VPNs, firewalls, load balancing, monitoring, and troubleshooting complex issues. You'll automate routine tasks and document architectures that scale with the business.",
    salary: 105_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Embedded Systems Engineer",
    company: "Hardware Solutions",
    location: "Munich",
    description:
      "Design and implement firmware and low-level software for resource-constrained devices. You'll work on driver development, RTOS integration, performance tuning, and hardware bring-up while collaborating closely with electrical and mechanical engineers. Experience with C/C++, debugging tools, and communication protocols is expected.",
    salary: 100_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Data Analyst",
    company: "Analytics Co.",
    location: "New Delhi",
    description:
      "Transform raw data into clear insights that inform product and business decisions. You'll build dashboards, write analyses, and run experiments while partnering with stakeholders to define metrics and measure outcomes. Proficiency in SQL, data visualization, and statistical reasoning is required.",
    salary: 95000
  },
  %DevJobs.JobListings.JobListing{
    title: "Cloud Architect",
    company: "Cloud Services",
    location: "Seattle",
    description:
      "Own cloud architecture and platform strategy to enable secure, scalable, and cost-effective services. You'll design multi-account topologies, networking, identity, observability, and IaC while guiding teams on best practices for reliability and performance.",
    salary: 105_000
  },
  %DevJobs.JobListings.JobListing{
    title: "IT Support Specialist",
    company: "Tech Support",
    location: "San Francisco",
    description:
      "Deliver outstanding Tier 1/2 support across devices, applications, and networks. You'll triage and resolve incidents, manage onboarding/offboarding, maintain asset inventories, and document SOPs while driving improvements to reduce recurring issues and improve employee experience.",
    salary: 100_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Blockchain Developer",
    company: "Crypto Solutions",
    location: "New York",
    description:
      "Crypto Solutions is revolutionizing the blockchain space, and we need a skilled Blockchain Developer to help build the future of decentralized finance! You'll be developing smart contracts and DeFi applications on multiple blockchain platforms. Key responsibilities include: designing and implementing smart contracts, developing web3 interfaces, ensuring contract security, and optimizing gas efficiency. Required skills: Solidity, Web3.js/Ethers.js, experience with ERC standards, and knowledge of DeFi protocols. Understanding of consensus mechanisms and cryptography is a plus. Benefits include: Competitive salary, crypto payments option, flexible work hours, and regular blockchain conferences attendance.",
    salary: 95000
  },
  %DevJobs.JobListings.JobListing{
    title: "Systems Administrator",
    company: "System Management",
    location: "Chicago",
    description:
      "Operate and harden Linux/Windows servers, virtualization, backups, and identity services. You'll automate routine maintenance, patching, and provisioning with IaC and configuration management tools while ensuring uptime, security, and compliance.",
    salary: 105_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Artificial Intelligence Researcher",
    company: "AI Labs",
    location: "Boston",
    description:
      "Advance the state of the art in machine learning through rigorous research and experimentation. You'll prototype novel models, analyze results, publish findings, and collaborate to bring research into production. Strong foundations in deep learning, optimization, and scientific communication are important.",
    salary: 100_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Software Tester",
    company: "Testing Co.",
    location: "Austin",
    description:
      "Design and execute manual and automated test plans to validate functionality, performance, and reliability. You'll work closely with engineering to identify root causes, verify fixes, and ensure high-quality releases. Experience with bug tracking, test case management, and exploratory testing is desired.",
    salary: 95000
  },
  %DevJobs.JobListings.JobListing{
    title: "Frontend Architect",
    company: "Web Solutions",
    location: "Los Angeles",
    description:
      "Define frontend architecture and standards for performance, accessibility, and developer productivity. You'll lead component design, state management strategy, code-splitting, testing, and tooling, while mentoring engineers and partnering with design on systematized UI libraries.",
    salary: 105_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Data Engineer",
    company: "Data Solutions",
    location: "Denver",
    description:
      "Design, build, and operate reliable data pipelines and lake/warehouse architectures. You'll model data, orchestrate workflows, ensure data quality, and enable analytics/ML use cases with well-documented, discoverable datasets.",
    salary: 100_000
  },
  %DevJobs.JobListings.JobListing{
    title: "UX Researcher",
    company: "User Research",
    location: "London",
    description:
      "Plan and conduct generative and evaluative research to uncover user needs and validate solutions. You'll run studies, synthesize insights, and communicate findings to influence product direction. Methods include interviews, usability testing, surveys, and diary studies.",
    salary: 95000
  },
  %DevJobs.JobListings.JobListing{
    title: "Software Architect",
    company: "Architect Co.",
    location: "Berlin",
    description:
      "Lead technical direction for complex systems by defining architectural patterns, integration strategies, and non-functional requirements. You'll review designs, guide teams through trade-offs, and ensure scalability, observability, and security are first-class concerns.",
    salary: 105_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Product Owner",
    company: "Product Management",
    location: "San Diego",
    description:
      "Translate business objectives into actionable backlog items and prioritize for maximum impact. You'll collaborate daily with engineering and design, refine requirements, and ensure the team delivers incremental value aligned with customer needs and company strategy.",
    salary: 100_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Backend Architect",
    company: "Tech Solutions",
    location: "Toronto",
    description:
      "Define backend service architectures emphasizing reliability, scalability, and maintainability. You'll lead domain modeling, API design, data storage strategies, and observability while guiding teams in best practices for distributed systems.",
    salary: 95000
  },
  %DevJobs.JobListings.JobListing{
    title: "Data Visualization Specialist",
    company: "Data Analytics",
    location: "Sydney",
    description:
      "Design and build compelling, trustworthy visualizations that make complex data easy to understand. You'll work closely with analysts and stakeholders to craft dashboards, define metrics, and tell clear stories with data while ensuring accuracy and usability.",
    salary: 105_000
  },
  %DevJobs.JobListings.JobListing{
    title: "IT Project Manager",
    company: "Project Management",
    location: "Washington D.C.",
    description:
      "Deliver complex IT projects on time and within scope by coordinating cross-functional teams, managing risks, and communicating progress to stakeholders. You'll own planning, execution, vendor coordination, and continuous improvement of delivery processes.",
    salary: 100_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Mobile App Tester",
    company: "App Testing",
    location: "Tokyo",
    description:
      "Plan and execute manual and automated tests across iOS/Android to ensure performant, reliable mobile experiences. You'll validate across devices, screen sizes, and network conditions, track issues, and collaborate to improve release quality.",
    salary: 95000
  },
  %DevJobs.JobListings.JobListing{
    title: "Network Security Engineer",
    company: "Security Solutions",
    location: "Paris",
    description:
      "Design and operate network security controls including firewalls, IDS/IPS, WAFs, and zero trust architectures. You'll harden configurations, automate policy management, and respond to security events while partnering with IT and SecOps to reduce risk.",
    salary: 105_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Firmware Engineer",
    company: "Hardware Solutions",
    location: "Munich",
    description:
      "Build robust firmware for high-reliability devices, from bootloaders to application layers. You'll optimize for power, memory, and latency while ensuring testability and maintainability. Experience with hardware debugging tools and secure update mechanisms is beneficial.",
    salary: 100_000
  },
  %DevJobs.JobListings.JobListing{
    title: "Business Analyst",
    company: "Business Solutions",
    location: "New Delhi",
    description:
      "Elicit and document clear, testable requirements by collaborating with stakeholders across functions. You'll map current processes, identify gaps, propose improvements, and support teams through implementation and change management while measuring impact.",
    salary: 95000
  }
]

# Insert the job listings into the database
Enum.each(job_listings, fn job_listing ->
  DevJobs.Repo.insert!(job_listing)
end)
