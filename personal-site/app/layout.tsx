import type { Metadata } from "next";
import { Fraunces, Outfit } from "next/font/google";
import "./globals.css";

const display = Fraunces({
  variable: "--font-display",
  subsets: ["latin"],
  axes: ["SOFT", "WONK", "opsz"],
});

const body = Outfit({
  variable: "--font-body",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "David Skadron",
  description:
    "When I notice problems, I actually look for solutions — SkadApp, BluWorld, and stories that reach millions.",
  metadataBase: new URL("https://www.davidskad.com"),
  openGraph: {
    title: "David Skadron",
    description:
      "AI for veterinarians. A social network for real-life adventure. The man who says he can, and the man who says he cannot are both correct.",
    url: "https://www.davidskad.com",
    siteName: "David Skadron",
    type: "website",
    locale: "en_US",
  },
  twitter: {
    card: "summary_large_image",
    title: "David Skadron",
    description:
      "AI for veterinarians. A social network for real-life adventure. The man who says he can, and the man who says he cannot are both correct.",
    creator: "@DavidSkadron",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${display.variable} ${body.variable} h-full antialiased`}>
      <body className="min-h-full atmosphere font-sans">{children}</body>
    </html>
  );
}
