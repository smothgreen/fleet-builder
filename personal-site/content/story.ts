export const site = {
  name: "David Skadron",
  email: "hello@davidskad.com",
  linkedin: "https://www.linkedin.com/in/davidskadron/",
  x: "https://x.com/DavidSkadron",
  domain: "davidskad.com",
} as const;

export const nav = [
  { id: "skadapp", label: "SkadApp" },
  { id: "bluworld", label: "BluWorld" },
  { id: "craft", label: "Craft" },
  { id: "story", label: "Story" },
  { id: "contact", label: "Contact" },
] as const;

export const hero = {
  name: "David Skadron",
  thesis:
    "I build products that give people their time and their world back.",
  supporting:
    "AI for veterinarians. A social network for real-life adventure. Media that moves millions.",
  cta: "Work with me",
  portrait: "/images/hero/portrait.jpg",
} as const;

export const origin = {
  id: "skadapp",
  eyebrow: "Origin",
  title: "A family of veterinarians. Software that wastes their day.",
  body: [
    "Both of my parents and my grandpa are veterinarians. I grew up watching them pour everything into animals — and lose hours to ugly clinic software that fights them at every click.",
    "I wanted to build something that gives that time back. So I started SkadApp: an AI veterinary super-app that cuts busywork so doctors can spend more time helping animals.",
  ],
  product: {
    name: "SkadApp",
    feature: "Toto AI",
    featureLine:
      "A voice assistant clinicians can ask anything — about a patient, a protocol, a next step — without leaving the moment of care.",
    image: "/images/skadapp/toto-listening.png",
    imageAlt: "SkadApp Toto AI listening interface",
    logo: "/images/skadapp/logo.png",
    logoAlt: "Skadron Animal Hospital logo",
  },
} as const;

export const bluworld = {
  id: "bluworld",
  eyebrow: "Product",
  title: "BluWorld",
  subtitle: "A social network that rewards real-world adventure — not mindless scrolling.",
  body: "I founded BluWorld to flip the feed: nearby events, side quests in any city, and friends who show up in the world instead of disappearing into a screen.",
  screens: [
    {
      src: "/images/bluworld/sidequest.png",
      alt: "BluWorld home with a nearby State Street side quest",
      caption: "Side quests — cool things to do in any city",
    },
    {
      src: "/images/bluworld/events.png",
      alt: "BluWorld events feed for Madison",
      caption: "Events that pull you outside",
    },
    {
      src: "/images/bluworld/map-home.png",
      alt: "BluWorld map home screen",
      caption: "A living map of adventure",
    },
  ],
  globe: "/images/bluworld/globe.png",
} as const;

export const craft = {
  id: "craft",
  eyebrow: "Craft",
  title: "Storytelling as a product skill.",
  film: {
    title: "Ice Cold Nikes",
    line: "Wrote, produced, and directed. Short Film Production Award — University of Wisconsin–Madison Film Festival.",
    youtubeId: "bF0vgQVvVr8",
    url: "https://youtu.be/bF0vgQVvVr8",
    poster: "/images/craft/ice-cold-nikes-thumb.jpg",
  },
  campaign: {
    title: "Millions of views from Madison",
    line: "While interning for Congressman Dean Phillips and later supporting his presidential campaign, I couldn’t be in New Hampshire. I stayed a student in Madison, taught myself video editing, and made campaign videos that reached millions of views.",
    xUrl: "https://x.com/DavidSkadron/status/1751667940783476808",
    poster: "/images/craft/campaign-poster.jpg",
  },
} as const;

export const howIMove = {
  id: "story",
  eyebrow: "How I move",
  title: "I notice what’s broken — then I organize people to fix it.",
  beats: [
    {
      title: "Ice cream for every dining hall",
      body: "Freshman year I started with a dorm whiteboard tally, then a petition that grew past 800 signatures. Today there are ice cream machines in every UW–Madison dining hall — and local news covered the win.",
      image: "/images/media/ice-cream-news-thumb.jpg",
      youtubeId: "wdv0C_SIBFY",
      url: "https://youtu.be/wdv0C_SIBFY",
      linkLabel: "Watch the news segment",
    },
    {
      title: "Congress, then craft under constraint",
      body: "As a District Ambassador in Congressman Dean Phillips’ office I briefed issues, helped constituents, and coordinated community events — then turned distance into a media skill when the campaign needed video.",
      image: "/images/craft/campaign-poster.jpg",
      url: "https://x.com/DavidSkadron/status/1751667940783476808",
      linkLabel: "Watch the viral campaign video",
    },
    {
      title: "Leadership when community needed it",
      body: "After October 7th, I stepped up as a leader in the Jewish community on campus — organizing, speaking, and showing up when people needed steadiness under pressure.",
      image: "/images/craft/film-2.jpg",
    },
  ],
} as const;

export const experience = {
  eyebrow: "Selected experience",
  items: [
    {
      role: "Innovation Consultant",
      org: "Weinhart Entrepreneurship Clinic",
      year: "2024",
      line: "Advised founders and local businesses through real growth constraints.",
    },
    {
      role: "Operations Intern",
      org: "Augeo Engagement Technologies",
      year: "2023",
      line: "Worked with executives on operations insight and competitor analysis.",
    },
    {
      role: "District Ambassador",
      org: "Office of Congressman Dean Phillips",
      year: "2022",
      line: "Legislative research, constituent support, and community events.",
    },
    {
      role: "Elementary School Aid",
      org: "Nir Etzion Elementary School",
      year: "2021",
      line: "Taught English daily and helped keep classrooms calm and productive.",
    },
  ],
} as const;

export const education = {
  school: "University of Wisconsin–Madison",
  detail:
    "Double major in Information Science and Communication Arts. Certificates in Entrepreneurship, Digital Studies, and Sports Communication.",
  highlights: [
    "Outstanding Project — Badger Buildfest Hackathon",
    "Short Film Production Award — UW–Madison Film Festival",
    "3rd — Minnesota statewide high school debate",
    "National Honor Society President",
  ],
} as const;

export const close = {
  id: "contact",
  title: "Building toward ambitious product teams.",
  body: "I’m looking for places that care about craft, systems, and human outcomes — companies like SpaceX AI and Apple. If you’re hiring builders who ship with taste, I’d love to talk.",
  ctaPrimary: "Email David",
  ctaSecondary: "LinkedIn",
} as const;
