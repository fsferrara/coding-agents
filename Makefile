CLAUDE_HOME ?= $(HOME)/.claude
REPO_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
KINDS := agents skills commands

.PHONY: install uninstall status

install:
	@skips=0; \
	for kind in $(KINDS); do \
	  mkdir -p "$(CLAUDE_HOME)/$$kind"; \
	  for src in "$(REPO_ROOT)/$$kind"/*/; do \
	    [ -d "$$src" ] || continue; \
	    src="$${src%/}"; \
	    name="$$(basename "$$src")"; \
	    dest="$(CLAUDE_HOME)/$$kind/$$name"; \
	    if [ -L "$$dest" ]; then \
	      target="$$(readlink "$$dest")"; \
	      if [ "$$target" = "$$src" ]; then \
	        printf "ok      %s/%s\n" "$$kind" "$$name"; \
	      else \
	        printf "skip    %s/%s (points to %s)\n" "$$kind" "$$name" "$$target"; \
	        skips=$$((skips + 1)); \
	      fi; \
	    elif [ -e "$$dest" ]; then \
	      printf "skip    %s/%s (not a symlink)\n" "$$kind" "$$name"; \
	      skips=$$((skips + 1)); \
	    else \
	      ln -s "$$src" "$$dest"; \
	      printf "linked  %s/%s\n" "$$kind" "$$name"; \
	    fi; \
	  done; \
	done; \
	if [ "$$skips" -gt 0 ]; then exit 1; fi

uninstall:
	@for kind in $(KINDS); do \
	  [ -d "$(CLAUDE_HOME)/$$kind" ] || continue; \
	  for dest in "$(CLAUDE_HOME)/$$kind"/*; do \
	    [ -L "$$dest" ] || continue; \
	    name="$$(basename "$$dest")"; \
	    target="$$(readlink "$$dest")"; \
	    case "$$target" in \
	      "$(REPO_ROOT)"/*) \
	        rm "$$dest"; \
	        printf "removed %s/%s\n" "$$kind" "$$name" ;; \
	      *) \
	        printf "kept    %s/%s (points to %s)\n" "$$kind" "$$name" "$$target" ;; \
	    esac; \
	  done; \
	done

status:
	@for kind in $(KINDS); do \
	  for src in "$(REPO_ROOT)/$$kind"/*/; do \
	    [ -d "$$src" ] || continue; \
	    src="$${src%/}"; \
	    name="$$(basename "$$src")"; \
	    dest="$(CLAUDE_HOME)/$$kind/$$name"; \
	    if [ -L "$$dest" ]; then \
	      target="$$(readlink "$$dest")"; \
	      if [ "$$target" = "$$src" ]; then \
	        printf "ok      %s/%s\n" "$$kind" "$$name"; \
	      else \
	        printf "skip    %s/%s (points to %s)\n" "$$kind" "$$name" "$$target"; \
	      fi; \
	    elif [ -e "$$dest" ]; then \
	      printf "skip    %s/%s (not a symlink)\n" "$$kind" "$$name"; \
	    else \
	      printf "missing %s/%s\n" "$$kind" "$$name"; \
	    fi; \
	  done; \
	done
