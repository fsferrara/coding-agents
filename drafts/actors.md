  ┌────────────┬────────────────────┬─────────────────────────────────────────────────────────────────────────────┐
  │   Agent    │    SDLC Phases     │                                 Key Skills                                  │                                                                                                                      
  ├────────────┼────────────────────┼─────────────────────────────────────────────────────────────────────────────┤
  │ Specifier  │ Planning, Analysis │ write spec, refine spec, estimate effort, gather requirements, define scope │                                                                                                                      
  ├────────────┼────────────────────┼─────────────────────────────────────────────────────────────────────────────┤
  │ Architect  │ Design             │ system design, API design, data modeling, threat modeling, prototype        │
  ├────────────┼────────────────────┼─────────────────────────────────────────────────────────────────────────────┤
  │ Builder    │ Development        │ implement feature, refactor, write unit tests, debug                        │
  ├────────────┼────────────────────┼─────────────────────────────────────────────────────────────────────────────┤
  │ Verifier   │ Testing, Review    │ code review, security review, test cases, regression analysis               │
  ├────────────┼────────────────────┼─────────────────────────────────────────────────────────────────────────────┤
  │ Deployer   │ Deployment         │ release plan, staged rollout, rollback plan, monitor release                │
  ├────────────┼────────────────────┼─────────────────────────────────────────────────────────────────────────────┤
  │ Documenter │ All phases         │ write docs, update changelog, API docs, maintain README                     │
  └────────────┴────────────────────┴─────────────────────────────────────────────────────────────────────────────┘

  Flow:

  Specifier → Architect → Builder → Verifier → Deployer
                  ↑           ↑          ↑          ↑
                  └───────────┴──────────┴──────────┘
                           Documenter

  This gives you clear ownership:
  - Specifier answers "what and why"
  - Architect answers "how"
  - Builder answers "make it work"
  - Verifier answers "does it work correctly"
  - Deployer answers "get it to users"
  - Documenter captures knowledge throughout