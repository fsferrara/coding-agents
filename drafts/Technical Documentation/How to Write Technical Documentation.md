# How to Write Technical Documentation

Technical documentation exists to give people accurate information fast.

That is the central standard. A document can be technically sophisticated, detailed, and well intentioned, but if readers cannot find it, trust it, scan it, or act on it, the document has failed. Good documentation reduces the time between a reader having a question and the reader being able to do the work.

This matters because technical work creates constant knowledge gaps. Engineers need setup instructions. Operators need runbooks. Product teams need decisions preserved. New team members need context. Future maintainers need to understand why a system behaves the way it does. Without durable documentation, the same answers move through chat, meetings, tickets, and hallway conversations again and again.

Documentation is automated communication. It lets a team answer a question once and reuse the answer many times. It also clarifies the writer's thinking. If you cannot explain a system clearly, you may not understand it well enough yet. Writing exposes missing logic, vague assumptions, and half-formed decisions.

The goal is not to create more pages. The goal is to create a trusted body of knowledge that people use before interrupting someone else.

## Write for readers who are trying to leave

Readers rarely approach technical documentation as recreational reading. They are trying to complete a task, unblock themselves, verify a detail, or make a decision. The document is a means to an end.

That changes how you should write.

Readers scan. They jump between headings. They look for commands, field names, examples, warnings, and exact answers. They satisfice: they stop as soon as they find something good enough to move forward. If a page looks like it will require too much effort, they leave. If they lose faith in the document once, they may stop trusting the whole documentation set.

Write with that behavior in mind, not the behavior you wish readers had. Do not assume they will read from top to bottom. Do not bury prerequisites in the middle. Do not hide the answer behind a long explanation. Do not make readers infer which version, file, team, environment, or command you mean.

The reader's goal is information. Accurate information. Fast.

Accuracy comes first because inaccurate documentation is worse than missing documentation. Missing documentation creates friction. Wrong documentation destroys trust. Speed comes next because a correct document that is slow to use still pushes readers back toward asking people directly.

Every documentation decision should serve those two goals.

## Make documentation part of the work

Documentation stays useful only when it changes with the system. Treat it like tests: part of the change, not a cleanup task to remember later.

When behavior changes, ask three questions:

1. What document needs to change?
2. Does that document already exist?
3. If it does not exist, should it exist?

Add or update documentation when the information will be needed again, is easy to forget, matters beyond one person, or is already being asked about repeatedly. Do not create a page just because you can. A page that no one needs becomes clutter; clutter slows down the entire documentation system.

Budget time for documentation when estimating technical work. If a change affects setup, behavior, operations, architecture, permissions, workflows, or troubleshooting, the documentation work is not optional. It is part of delivering the change.

This habit prevents the most common failure mode: a documentation set that was once useful but slowly became unreliable. Documentation is difficult because it lasts. Chat messages, meetings, and project notes can expire naturally. Durable documentation must be maintained because readers expect it to remain true.

The work is not finished when the code changes. The work is finished when future readers can understand and use the change without reconstructing it from conversations.

## Put knowledge in the right place

Before writing, decide where the content belongs. Information architecture matters as much as sentence quality. A clear sentence in the wrong location is still hard to use.

Different kinds of information need different homes:

| Information type | Better home | Expected lifespan |
|---|---|---|
| Quick conversation, status, and one-off questions | Chat or comments | Minutes to days |
| Research notes or decisions in progress | Issue tracker, design document, or project workspace | Days to weeks |
| Repo-specific setup, behavior, and operations | Repository documentation | Months to years |
| Cross-team concepts, policies, workflows, and shared systems | Central documentation hub or knowledge base | Months to years |

Use conversations for conversation. Use durable documentation for durable knowledge.

Important answers should not live only in chat threads, page comments, code review discussions, tickets, or email chains. Those places are useful while people are discovering the answer. They are poor places to store the answer once it is known.

When a conversation produces reusable knowledge, move the knowledge into the document itself. If a ticket clarifies a process, update the relevant page. If a code review discussion explains why a configuration exists, add that explanation where future maintainers will look. If a chat answer resolves a common question, add it to the guide and send the link next time.

The placement decision should be obvious to future readers. They should not need to guess which tool, space, repository, or page contains the trusted answer.

## Build one hierarchy

A documentation set is not only a collection of pages. It is a system. Like code, it needs architecture.

Without information architecture, documentation becomes piles of text. Readers may know an answer exists somewhere, but they cannot predict where. They search, open several similar pages, compare dates, ask someone else, and eventually learn that documentation is unreliable.

Build one hierarchy and maintain it.

Group related content together. Put setup near setup, troubleshooting near troubleshooting, architecture near architecture, and policies near policies. If a topic could reasonably live in more than one place, choose one canonical home and link to it from elsewhere.

Choose an ordering system intentionally. Navigation communicates before a reader opens any page. Useful ordering patterns include:

- Most important first
- Most frequently used first
- Chronological order
- Dependency order, where one thing must exist before the next

Do not leave the order accidental. Accidental order makes the system feel arbitrary, and arbitrary navigation slows readers down.

Limit either depth or breadth. A flat hierarchy has fewer levels and more options at each level. It works well when the domain is simple and top-level categories are obvious. A deep hierarchy has more levels and fewer options at each level. It works well when the subject is complex but each click is a clear choice.

Avoid a hierarchy that is both broad and deep. That gives readers too many choices at every step.

The hierarchy must also scale. A structure that works for twenty pages should still make sense when it has two hundred. Before adding a new top-level section, ask whether the existing categories can absorb the content. Before creating a special exception, ask whether the exception will become a pattern.

One maintained hierarchy gives readers confidence. Multiple competing hierarchies create hesitation, duplication, and drift.

## Keep one source of truth

Duplicate documentation is expensive. It looks helpful at first because the same answer appears in several places, but it creates uncertainty as soon as one copy changes and another does not.

Keep documentation DRY: do not repeat yourself.

Say something once in one canonical place. Link to it when other pages need the same information. This rule applies to setup instructions, architecture explanations, process descriptions, command examples, contact information, and troubleshooting steps.

Duplicate content creates three common problems:

- Readers waste time deciding which version is correct.
- Writers update one copy and forget the others.
- Search results show several similar answers with different levels of freshness.

The solution is not to hide information. The solution is to make one page authoritative and make other pages point to it clearly.

This also affects how teams answer questions. When someone asks a question that is already documented, send the link to the document. Do not rewrite the answer in chat unless the document is wrong or incomplete. If the document is wrong, fix it first, then send the link.

That behavior reinforces the habit you want: use the documentation first, ask people second.

## Remove what gets in the way

Good documentation is not only written. It is pruned.

Anything that is not contributing is in the way. Outdated pages, duplicate pages, empty sections, misleading titles, dead links, long introductions, template leftovers, and obsolete screenshots all increase the reader's cost.

Remove outdated content first. It is the highest-cost problem because it damages trust. When you find stale content, fix it if you can validate it quickly. Remove it if you cannot. Redirect to the correct source if another page has replaced it.

Do not leave known-bad instructions in place because removing them feels disruptive. Known-bad information is already disruptive.

Remove duplicate content next. If two pages explain the same process, choose the canonical page, improve it, and replace the other copy with a link or remove it. If multiple sections repeat the same background, keep the strongest version and link back to it.

Then remove noise. Cut empty sections. Delete stub pages that promise future content but do not help current readers. Replace broad titles with specific ones. Remove introductions that explain what the document will do instead of doing it.

Pruning is not cosmetic cleanup. It is performance work. The less noise readers encounter, the more likely they are to trust and reuse the documentation.

## Shape each page for scanning

A page should reveal its value quickly, even to someone who reads only the headings, lists, commands, and examples.

Lead with the answer, outcome, or purpose. If the page tells readers how to rotate a key, say that immediately. If it explains why a service has a particular design, state the design decision before giving history. If it compares options, show the recommendation near the top.

Put prerequisites early. Readers should not discover halfway through a procedure that they need access, a specific version, a feature flag, or a prepared environment.

Use a predictable structure. For procedural pages, a strong default is:

1. Purpose
2. Prerequisites
3. Steps
4. Verification
5. Troubleshooting
6. Related links

Do not force every page into the same template. An architecture overview, runbook, onboarding guide, and troubleshooting page have different needs. But give readers a recognizable pattern so they know where to look.

Use headings to chunk the content. Every distinct idea deserves a heading or subheading. Good headings let readers skip irrelevant material, build a mental map, and return later to the same section.

Prefer lists when the information is parallel, sequential, or option-based. Steps, requirements, causes, symptoms, outcomes, and examples are usually easier to scan as lists than as dense paragraphs.

Be specific. Specific writing is faster than vague writing. Use exact file paths instead of "the config file." Use exact commands instead of paraphrases. Use exact versions instead of "recently" or "latest" unless the actual version is intentionally variable. Use exact page and team names instead of "the other doc" or "the responsible team."

End with validation when validation matters. A reader should know how to tell whether the task worked. For operational or setup documentation, verification steps often matter as much as the steps themselves.

## Write sentences that move quickly

Technical writing should reduce mental processing time. That does not mean removing necessary detail. It means removing avoidable friction.

Be concise. Extra words slow the reader down.

| Weak | Better |
|---|---|
| The application is using a feature flag service in order to run an A/B test. | The application uses a feature flag service to run an A/B test. |
| You will simply need to provide the end string. | Provide the end string. |
| This document will explain how to configure the worker. | Configure the worker as follows. |

Remove filler such as `please`, `simply`, `just`, `in order to`, `you can`, and `this document will explain`. These phrases rarely add meaning.

Use active voice. Active voice is usually shorter and clearer because it names the actor.

Prefer:

- `Use the package manager to install packages.`
- `The deployment job creates the release tag.`
- `The service reads configuration from config.yaml.`

Avoid:

- `The package manager is used to install packages.`
- `The release tag is created by the deployment job.`
- `Configuration is read by the service from config.yaml.`

Use one term for one thing. If a component is called `event processor`, do not also call it `worker`, `task runner`, and `background job` unless those names mean different things. Inconsistent naming makes readers pause and compare concepts that may not actually differ.

The same rule applies to headings and links. Link text should match the destination when possible. If a link says `Runtime configuration`, the page should not be titled `Required and recommended settings` unless there is a good reason.

Start headings and list items with verbs when the content is action-oriented. Verb-led phrasing tells readers what to do and often prevents nominalizations.

Prefer:

- `Use and Contribute` instead of `Using and Contributing`
- `Include the component on your page` instead of `Including the component on your page`
- `Override local values` instead of `Local value overrides`
- `Format a change request` instead of `Change request format`

Use simple language. Simple language is not less technical. It is more direct. Prefer `use` over `utilize`, `before` over `prior to`, `if` over `in the event that`, and `must` over `one must`.

Avoid noun strings. Long stacks of nouns force readers to unpack relationships. Replace compressed phrases with clear structure. Instead of `cache invalidation failure response process`, write `how to respond when cache invalidation fails`.

Avoid unnecessary formality. Documentation should sound like a clear explanation from a competent colleague. It should be direct, factual, and useful.

## Follow a repeatable writing workflow

A repeatable workflow prevents documentation quality from depending on inspiration.

Start by defining the reader. Be precise. "Engineers" is often too broad. "Service maintainers setting up the local development environment for the first time" is useful.

State the question the document answers. A good document has a job. If you cannot state the job, the page will likely drift.

Choose the canonical home before drafting. Check whether an existing page should be updated instead of creating a new one. Extending the right page is often better than adding a new page.

Sketch the headings before writing paragraphs. Headings reveal structure problems early. If the headings do not create a clear path, more prose will not fix the page.

Draft quickly, then revise deliberately. First make the page accurate and complete enough to be useful. Then revise for hierarchy, scan speed, specificity, and concision.

Validate anything readers will copy, click, or trust. Test commands. Check links. Confirm file paths. Verify versions. Make sure screenshots, diagrams, and examples match the current system.

Publish the document where readers already expect to find it. Then use it. When someone asks the question it answers, send the link. If the link does not answer the question well enough, improve the document.

Documentation improves through use. A page that is never used cannot earn trust. A page that is used, corrected, and linked becomes part of how the team works.

## Use this checklist before publishing

Before publishing or updating technical documentation, check the work against the standard:

- Can you state the one question this document answers?
- Is the intended reader clear?
- Does the page lead with the answer, outcome, or purpose?
- Is this the correct home for the content?
- Does an existing page already cover the topic?
- Is there one canonical source instead of several competing versions?
- Can readers find the page through navigation without relying only on search?
- Is the hierarchy logical, intentional, and scalable?
- Is every instruction accurate today?
- Did you remove outdated, duplicated, empty, or misleading content?
- Did you move durable knowledge out of comments, chat, tickets, or email?
- Are titles and headings specific?
- Are links current and useful?
- Are commands, paths, names, versions, and permissions exact?
- Are examples neutral unless the document is about a specific vendor, product, or organization?
- Did you use lists where they improve scanning?
- Did you remove filler words and politeness padding?
- Did you use one term consistently for each concept?
- Did you prefer active voice and simple language?
- Did you avoid noun strings, nominalizations, and unnecessary formality?
- Did you include verification or troubleshooting where readers need it?

The best documentation is not the longest or most polished. It is the documentation readers trust, find quickly, understand easily, and use before asking someone else.

Write for that outcome. Put the answer where it belongs. Keep it current. Remove what gets in the way. Make the next reader faster.
