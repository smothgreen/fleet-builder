import { SiteNav } from "@/components/SiteNav";
import { Hero } from "@/components/Hero";
import { OriginSkadApp } from "@/components/OriginSkadApp";
import { BluWorld } from "@/components/BluWorld";
import { Craft } from "@/components/Craft";
import { HowIMove } from "@/components/HowIMove";
import { Experience } from "@/components/Experience";
import { Close } from "@/components/Close";

export default function Home() {
  return (
    <>
      <SiteNav />
      <main>
        <Hero />
        <OriginSkadApp />
        <BluWorld />
        <HowIMove />
        <Craft />
        <Experience />
        <Close />
      </main>
    </>
  );
}
