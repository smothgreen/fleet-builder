export const site = {
  name: "David Skadron",
  email: "hello@davidskad.com",
  linkedin: "https://www.linkedin.com/in/davidskadron/",
  x: "https://x.com/davidskadron?s=21",
  domain: "davidskad.com",
} as const;

export const nav = [
  { id: "skadapp", label: "SkadApp" },
  { id: "bluworld", label: "BluWorld" },
  { id: "story", label: "Story" },
  { id: "craft", label: "Craft" },
  { id: "contact", label: "Contact" },
] as const;

export const hero = {
  name: "David Skadron",
  quote:
    "The man who says he can, and the man who says he cannot are both correct.",
  quoteAttribution: "Confucius",
  cta: "Work with me",
  portrait: "/images/hero/portrait.jpg",
} as const;

export const origin = {
  id: "skadapp",
  eyebrow: "Origin",
  title: "Veterinary care runs in my family. So does frustration with clinic software.",
  titleLines: [
    "Veterinary care runs in my family.",
    "So does frustration with clinic software.",
  ],
  body: [
    "My parents and grandfather are veterinarians. I grew up watching them care deeply for animals — then lose hours to software that made every task harder.",
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
      alt: "BluWorld map with a nearby State Street side quest",
      caption: "Side quests — cool things to do in any city",
    },
    {
      src: "/images/bluworld/events.png",
      alt: "BluWorld events feed for Madison",
      caption: "Find events worth leaving home for",
    },
    {
      src: "/images/bluworld/map-home.png",
      alt: "BluWorld map home screen",
      caption: "A living map of adventure",
    },
  ],
  globe: "/images/bluworld/globe.png",
  appStoreUrl: "https://apps.apple.com/us/app/bluworld/id6748724202",
} as const;

export const craft = {
  id: "craft",
  eyebrow: "Craft",
  title: "Storytelling.",
  film: {
    title: "Ice Cold Nikes",
    line: "Wrote, produced, and directed. Short Film Production Award — University of Wisconsin–Madison Film Festival.",
    youtubeId: "bF0vgQVvVr8",
    url: "https://youtu.be/bF0vgQVvVr8",
    poster: "/images/craft/ice-cold-nikes-thumb.jpg",
  },
} as const;

export const howIMove = {
  id: "story",
  eyebrow: "How I move",
  title: "When I see a problem, I move.",
  beats: [
    {
      title: "Ice cream for every dining hall",
      body: "My freshman year of college I started a petition, got 800 signatures, and now every dining hall on the University of Wisconsin–Madison campus has ice cream machines.",
      image: "/images/story/ice-cream-dining-hall.png",
      imageAlt: "David Skadron with soft-serve ice cream in a UW–Madison dining hall",
      url: "https://youtu.be/wdv0C_SIBFY",
      linkLabel: "Watch the news segment",
    },
    {
      title: "A long-shot campaign I had to join",
      body: "In the 2024 election, Joe Biden’s approval was collapsing and 77% of Americans wanted another choice. Congressman Dean Phillips was the lone Democrat calling on President Biden to step aside for a younger nominee. Even though most people didn’t know Congressman Phillips name, he took action and ran for president. It was a long shot, but I had to help. The campaign was on the ground in New Hampshire while I was a student in Madison, so I taught myself video editing and found a new way to contribute. The content I made reached over 4 million views.",
      image: "/images/story/dean-phillips-madison.png",
      imageAlt: "David Skadron posting a Dean Phillips for President flyer in Madison",
      url: "https://x.com/DavidSkadron/status/1751667940783476808",
      linkLabel: "Watch one of the viral campaign videos",
    },
  ],
} as const;

export const experience = {
  eyebrow: "Selected experience",
  items: [
    {
      role: "Strategic Advisor",
      org: "Weinhart Entrepreneurship Clinic",
      year: "2024",
      line: "Advised founders and local businesses through real growth constraints.",
    },
    {
      role: "Operations Intern",
      org: "Augeo Engagement Technologies",
      year: "2023",
      line: "Worked with executives on operational strategy and competitive research.",
    },
    {
      role: "District Ambassador",
      org: "Office of Congressman Dean Phillips",
      year: "2022",
      line: "Researched policy, supported constituents, and helped run community events.",
    },
    {
      role: "Elementary School Aide",
      org: "Nir Etzion Elementary School",
      year: "2021",
      line: "Taught English and helped create calm, productive classrooms.",
    },
  ],
} as const;

export const education = {
  school: "University of Wisconsin–Madison",
  detail:
    "Double major in Information Science and Communication Arts, with certificates in Entrepreneurship, Digital Studies, and Sports Communication.",
  highlights: [
    "Outstanding Project — Badger Buildfest Hackathon",
    "3rd place — Minnesota State High School Debate Tournament",
    "President — National Honor Society",
  ],
} as const;

export const close = {
  id: "contact",
  title: "Let’s build a better future.",
  body: "I’m looking for ambitious product teams that care about craft, clear thinking, and real human outcomes. If that sounds like your team, I’d love to talk.",
  ctaPrimary: "Message me",
  ctaSecondary: "LinkedIn",
} as const;
