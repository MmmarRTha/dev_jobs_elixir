DevJobs.Repo.insert!(%DevJobs.Users.User{
    id: 1,
    email: "martha.nieto.mi@gmail.com",
    avatar: "eaf3950d-f410-4837-9ca3-d7ac3aa4c017.jpg"
  })

# Create a list of job listings
job_listings = [
    %DevJobs.JobListings.JobListing{
        title: "Elixir Backend Developer",
        company: "Tech Solutions",
        location: "Seattle",
        description: "Join our backend development team and help build scalable systems.",
        salary: 95000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Full Stack Engineer",
        company: "WebTech",
        location: "Austin",
        description:
            "Looking for a versatile full stack engineer with experience in Elixir Phoenix LiveView framework.",
        salary: 105_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "iOS Mobile App Developer",
        company: "AppWorks",
        location: "Los Angeles",
        description: "Develop innovative mobile applications for our clients.",
        salary: 95000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "DevOps Engineer",
        company: "Cloud Solutions",
        location: "Denver",
        description: "Manage and automate our cloud infrastructure.",
        salary: 100_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "UI/UX Designer",
        company: "Design Co.",
        location: "London",
        description: "Create intuitive and visually appealing user interfaces.",
        salary: 90000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Machine Learning Engineer",
        company: "AI Solutions",
        location: "Berlin",
        description: "Work on cutting-edge machine learning algorithms.",
        salary: 110_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Product Manager",
        company: "Tech Startup",
        location: "San Diego",
        description: "Lead the development and launch of new products.",
        salary: 100_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Quality Assurance Engineer",
        company: "Testing Solutions",
        location: "Toronto",
        description: "Ensure the quality and reliability of our software products.",
        salary: 95000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Database Administrator",
        company: "Data Management",
        location: "Sydney",
        description: "Manage and optimize our database systems.",
        salary: 105_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Cybersecurity Analyst",
        company: "Security Solutions",
        location: "Washington D.C.",
        description: "Protect our systems from cyber threats and vulnerabilities.",
        salary: 100_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Game Developer",
        company: "Gaming Studios",
        location: "Tokyo",
        description: "Create immersive and engaging gaming experiences.",
        salary: 95000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Network Engineer",
        company: "Networking Solutions",
        location: "Paris",
        description: "Design and maintain our network infrastructure.",
        salary: 105_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Embedded Systems Engineer",
        company: "Hardware Solutions",
        location: "Munich",
        description: "Develop embedded systems for various applications.",
        salary: 100_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Data Analyst",
        company: "Analytics Co.",
        location: "New Delhi",
        description: "Analyze and interpret data to drive business insights.",
        salary: 95000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Cloud Architect",
        company: "Cloud Services",
        location: "Seattle",
        description: "Design and implement scalable cloud solutions.",
        salary: 105_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "IT Support Specialist",
        company: "Tech Support",
        location: "San Francisco",
        description: "Provide technical support to end users.",
        salary: 100_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Blockchain Developer",
        company: "Crypto Solutions",
        location: "New York",
        description: "Build decentralized applications using blockchain technology.",
        salary: 95000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Systems Administrator",
        company: "System Management",
        location: "Chicago",
        description: "Manage and maintain our computer systems and servers.",
        salary: 105_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Artificial Intelligence Researcher",
        company: "AI Labs",
        location: "Boston",
        description: "Conduct research in the field of artificial intelligence.",
        salary: 100_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Software Tester",
        company: "Testing Co.",
        location: "Austin",
        description: "Test and debug software applications.",
        salary: 95000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Frontend Architect",
        company: "Web Solutions",
        location: "Los Angeles",
        description: "Design and implement scalable frontend architectures.",
        salary: 105_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Data Engineer",
        company: "Data Solutions",
        location: "Denver",
        description: "Build and maintain data pipelines and ETL processes.",
        salary: 100_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "UX Researcher",
        company: "User Research",
        location: "London",
        description: "Conduct user research to inform product design decisions.",
        salary: 95000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Software Architect",
        company: "Architect Co.",
        location: "Berlin",
        description: "Design and oversee the architecture of software systems.",
        salary: 105_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Product Owner",
        company: "Product Management",
        location: "San Diego",
        description: "Define and prioritize product features and requirements.",
        salary: 100_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Backend Architect",
        company: "Tech Solutions",
        location: "Toronto",
        description: "Design and implement scalable backend architectures.",
        salary: 95000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Data Visualization Specialist",
        company: "Data Analytics",
        location: "Sydney",
        description: "Create visually appealing data visualizations and dashboards.",
        salary: 105_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "IT Project Manager",
        company: "Project Management",
        location: "Washington D.C.",
        description: "Manage and oversee IT projects from initiation to completion.",
        salary: 100_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Mobile App Tester",
        company: "App Testing",
        location: "Tokyo",
        description: "Test and ensure the quality of mobile applications.",
        salary: 95000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Network Security Engineer",
        company: "Security Solutions",
        location: "Paris",
        description: "Implement and maintain network security measures.",
        salary: 105_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Firmware Engineer",
        company: "Hardware Solutions",
        location: "Munich",
        description: "Develop firmware for embedded systems.",
        salary: 100_000,
        user_id: 1
    },
    %DevJobs.JobListings.JobListing{
        title: "Business Analyst",
        company: "Business Solutions",
        location: "New Delhi",
        description: "Gather and analyze business requirements.",
        salary: 95000,
        user_id: 1
    }
]

# Insert the job listings into the database
Enum.each(job_listings, fn job_listing ->
    DevJobs.Repo.insert!(job_listing)
end)
