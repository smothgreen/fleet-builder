# David Skadron — Personal Site

Cinematic personal website for [davidskad.com](https://www.davidskad.com). Built with Next.js, Tailwind CSS, and Framer Motion. **Not** part of Fleet Builder.

## Local development

```bash
cd personal-site
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000).

```bash
npm run build
npm start
```

## Stack

- Next.js App Router + TypeScript
- Tailwind CSS v4
- Framer Motion (scroll reveals, hero parallax, reduced-motion safe)
- Content lives in [`content/story.ts`](content/story.ts) for easy edits

## Deploy to Vercel (preview first)

From the repo root (or with Root Directory set to `personal-site`):

1. Import the GitHub repo in [Vercel](https://vercel.com/new).
2. Set **Root Directory** to `personal-site`.
3. Framework preset: Next.js. Build command `npm run build`, output default.
4. Deploy a preview, then promote to Production when it looks right.
5. Attach the custom domain (below).

CLI alternative (from this folder, after `vercel login`):

```bash
cd personal-site
npx vercel
npx vercel --prod
```

## Domain cutover (leave Wix, keep `davidskad.com`)

1. Deploy this app to Vercel (or connect the GitHub repo and import the `personal-site` folder as the root directory).
2. In the Vercel project: **Settings → Domains** → add `davidskad.com` and `www.davidskad.com`.
3. At your DNS host (Wix Domains or your registrar):
   - Remove Wix site pointing / old A/CNAME records for the apex and `www`.
   - Add the records Vercel shows (typically apex `A` → `76.76.21.21` and `www` `CNAME` → `cname.vercel-dns.com`).
4. Wait for DNS + SSL to go green in Vercel.
5. Only then unpublish or cancel **Wix site hosting**. Keep the **domain registration** if the domain is registered through Wix (or transfer it later).
6. Update the contact email in `content/story.ts` if `hello@davidskad.com` is not yet provisioned.

### If the domain is registered at Wix

- Wix → Domains → select `davidskad.com` → Manage DNS records → replace Wix pointing with Vercel’s records.
- Do **not** delete the domain from Wix until DNS is live elsewhere (or transfer the domain first).

### If the domain is at another registrar

- Point nameservers/DNS there to Vercel’s records and disconnect the domain from the Wix site.

## Assets

Wix media was downloaded into `public/images/` so the site does not depend on `static.wixstatic.com` after you leave Wix. Product screenshots for SkadApp / BluWorld live under `public/images/skadapp` and `public/images/bluworld`.

YouTube embeds from the old Wix homepage could not be resolved to public video IDs at build time; film stills are used in the Craft section. Drop real YouTube IDs into `content/story.ts` later if you want embeds.
