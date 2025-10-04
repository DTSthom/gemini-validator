# Gemini Validator

**Creator/Validator Architecture** - Use Claude Code for creation, Gemini for validation

Two-tool system for AI-assisted development with built-in validation:
- `gemini` - Quick chat with Gemini FLASH/PRO
- `gemini-validate` - Specialized validation (fact-checking, code security, logic analysis)

**🚀 Claude Code Integration**: Enable automatic validation inside Claude sessions with **zero token usage** - see [CLAUDE_INTEGRATION.md](CLAUDE_INTEGRATION.md)

## Philosophy

**Problem**: AI models can hallucinate, make logical errors, or miss security flaws
**Solution**: Use a second model as auditor to catch issues before they ship

**Pattern**: Claude creates → Gemini validates → Ship with confidence

## Installation

### One-Command Install (Recommended)

```bash
# Clone repository
git clone https://github.com/DTSthom/gemini-validator.git
cd gemini-validator

# Run installer (auto-detects sudo requirements)
./install.sh
```

The installer will:
- ✅ Check Python 3 availability
- ✅ Install `gemini` and `gemini-validate` to `/usr/local/bin`
- ✅ Set executable permissions
- ✅ Check for API key and provide setup instructions

### API Key Setup

**Get your API key**: https://aistudio.google.com/app/apikey

```bash
# Set for current session
export GOOGLE_API_KEY="your-api-key-here"

# Make permanent (add to ~/.bashrc)
echo 'export GOOGLE_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

**Verify installation**:
```bash
gemini "Hello, are you working?"
```

### Manual Installation (Alternative)

If you prefer manual setup:

```bash
sudo cp gemini gemini-validate /usr/local/bin/
sudo chmod +x /usr/local/bin/gemini /usr/local/bin/gemini-validate
```

## Quick Start

### Interactive Mode (New!)

Launch interactive mode with no arguments:

```bash
gemini
```

**Features**:
- 🗿 Custom prompt showing current model
- 🤖 Switch models on-the-fly: `flash`, `pro`, `lite`, `2.5`
- 🎭 16-persona validation integrated
- 📋 Run `all <content>` to analyze with all 16 personas
- 🔍 View persona prompts: `persona <name>`
- 📖 Full guide: `guide` or `help`
- 🚪 Exit cleanly: `exit` or `quit`

**Example session**:
```
🗿 gemini (flash) ❯ pro
✅ Switched to PRO model

🗿 gemini (pro) ❯ What is SOQM architecture?
[Gemini PRO response...]

🗿 gemini (pro) ❯ fact Python was released in 1991
[Fact-checking validation...]

🗿 gemini (pro) ❯ exit
👋 Exiting Gemini Validator
```

### Basic Chat (CLI Mode)

```bash
# Quick question
gemini "Explain async/await in Python"

# Creative response
gemini -t 0.9 "Write a haiku about debugging"

# Use Gemini PRO (more capable, slower)
gemini -m pro "Complex architectural question"

# Continue conversation
gemini -c "Tell me more about that"
```

### Validation Commands

```bash
# Fact-checking
gemini-validate fact "Python 3.12 was released in October 2023"

# Code security review
gemini-validate code "$(cat script.sh)"
gemini-validate code "user_input = request.form['data']"

# Logic analysis
gemini-validate logic "If all developers use AI, and AI makes mistakes, then all code has bugs"

# Resolve ambiguity
gemini-validate ambiguity "Should I use REST or GraphQL for my API?"

# Optimize prompts
gemini-validate optimize "I need you to carefully analyze this data..."
```

## Validation Types

### `fact` - Fact Checking
Verifies specific claims, numbers, dates, and assertions.

**Example**:
```bash
gemini-validate fact "whisper.cpp processes audio at 6.6x realtime"
```

**Output**:
- ✅/⚠️/❌ Verdict
- Confidence score (0-100%)
- Evidence for/against claim
- Alternative facts if claim is wrong

### `code` - Security Review
Checks code for vulnerabilities, security flaws, and best practice violations.

**Example**:
```bash
gemini-validate code "$(cat vulnerable_script.sh)"
```

**Checks**:
- Command injection risks
- Input validation
- Error handling
- Authentication/authorization flaws
- OWASP Top 10 vulnerabilities

### `logic` - Logic Analysis
Evaluates reasoning chains for logical consistency and fallacies.

**Example**:
```bash
gemini-validate logic "Since Gemini validated this code, it must be perfect"
```

**Detects**:
- Logical fallacies (appeal to authority, false dichotomy, etc.)
- Invalid inferences
- Hidden assumptions
- Circular reasoning

### `ambiguity` - Resolve Unclear Choices
Helps make decisions when multiple valid options exist.

**Example**:
```bash
gemini-validate ambiguity "Should I consolidate these 5 scripts or keep them separate?"
```

**Provides**:
- Pros/cons of each option
- Situational recommendations
- Trade-off analysis

### `optimize` - Prompt Optimization
Reduces token usage while preserving information quality.

**Example**:
```bash
gemini-validate optimize "Please carefully review this code and tell me if there are any issues..."
```

**Output**:
- Compressed version (30-50% reduction)
- Information preservation score
- Token savings estimate

### Multi-Perspective Analysis: 16 Personas

The validator includes 16 specialized personas that analyze content from different angles. Each persona brings a unique lens to uncover insights others might miss.

#### Core Validation Personas

**`practical`** - Hands-on Practitioner
- Focus: Immediate applicability, actionable insights
- Question: "What can I implement TODAY?"
- Best for: Feature requests, implementation decisions

**`critical`** - Critical Analyst
- Focus: Weaknesses, biases, gaps
- Question: "What flaws, risks, or assumptions are hidden here?"
- Best for: Risk assessment, quality control

**`strategic`** - Strategic Thinker
- Focus: Long-term implications, systems perspective
- Question: "What are the 3-5 year consequences?"
- Best for: Architecture decisions, roadmap planning

**`sonnet`** - Claude Sonnet 4.5 Optimizer
- Focus: Prompt engineering, token efficiency
- Question: "How can this be optimized for Sonnet 4.5?"
- Best for: Prompt optimization, extended thinking validation

#### Domain Expert Personas

**`security`** - Security Professional
- Focus: Vulnerabilities, threats, exploits
- Question: "How can this be exploited? What could go wrong?"
- Best for: Code review, system hardening

**`educational`** - Educational Expert
- Focus: Knowledge transfer, learning structure
- Question: "What can I LEARN from this?"
- Best for: Documentation, tutorials, teaching materials

**`scientific`** - Research Scientist
- Focus: Evidence, methodology, empirical validation
- Question: "What's the science? Are claims valid?"
- Best for: Fact-checking, research validation

**`philosophical`** - Philosophical Thinker
- Focus: Ethics, deeper meanings, values
- Question: "What does this mean for humanity and society?"
- Best for: Ethical considerations, value alignment

**`economic`** - Economic Analyst
- Focus: Financial dynamics, business models, incentives
- Question: "What are the economic implications?"
- Best for: Business decisions, monetization strategies

**`social`** - Sociologist
- Focus: Community dynamics, relationships, social structures
- Question: "How does this affect relationships and communities?"
- Best for: User experience, community building

**`historical`** - Historian
- Focus: Patterns, precedents, context
- Question: "Has this been tried before? What can history teach us?"
- Best for: Avoiding past mistakes, learning from precedent

#### Usage

**Single persona analysis**:
```bash
gemini-validate practical "Should we use microservices or monolith?"
gemini-validate security "$(cat auth_system.py)"
gemini-validate economic "New pricing model: $10/month unlimited vs $1/feature"
```

**Multi-perspective (via interactive mode)**:
```bash
gemini
🗿 gemini (flash) ❯ all Should we build this feature?
# Analyzes from all 16 perspectives
```

**View persona prompts**:
```bash
gemini
🗿 gemini (flash) ❯ persona critical
# Shows the exact prompt template for critical persona
```

## Real-World Usage Examples

### Example 1: Secure System Update Script

```bash
# Claude creates update script
cat > update.sh <<'EOF'
#!/bin/bash
packages=$(apt list --upgradable | cut -d'/' -f1)
sudo apt upgrade -y $packages
EOF

# Gemini validates security
gemini-validate code "$(cat update.sh)"
```

**Gemini Finds**: Command injection vulnerability in `$packages` expansion
**Fix**: Use bash arrays instead of string concatenation

### Example 2: Validate Performance Claims

```bash
# Claim from benchmarking
gemini-validate fact "Our SOQM architecture achieved 230x efficiency improvement"
```

**Gemini Validates**: Requires baseline measurement evidence (11,500 tokens → 50 tokens)

### Example 3: Architectural Decision

```bash
# Deciding on tool fragmentation
gemini-validate ambiguity "Should Prommel integration be a separate tool or flag in existing tool?"
```

**Gemini Recommends**: Integration with flag (less fragmentation, shared config)

### Example 4: Logic Check Before Shipping

```bash
# Validate reasoning in documentation
gemini-validate logic "Extended thinking mode costs more tokens, therefore always disable it for efficiency"
```

**Gemini Detects**: False dichotomy - missing nuance about when extended thinking adds value

## Integration with Claude Code

### Zero-Token Validation Inside Claude Sessions

**Problem**: Validating with Claude uses your Anthropic token budget
**Solution**: Claude can run `gemini-validate` via Bash tool - uses Google API tokens instead

> **📋 Quick Setup**: See [CLAUDE_INTEGRATION.md](CLAUDE_INTEGRATION.md) for a ready-to-copy template

### Setup Instructions

Add this to your `~/.claude/CLAUDE.md`:

```markdown
## 🔍 GEMINI VALIDATION PROTOCOL (Creator/Validator Architecture)
**Claude = Creator/Doer | Gemini = Auditor/Validator**

**🚀 ZERO TOKEN USAGE**: Claude uses Bash tool to run validations outside session

## Quick Commands (Claude runs via Bash tool)
- `gemini-validate fact "claim"` - Verify facts/numbers/dates
- `gemini-validate code "$(cat file.py)"` - Security review code
- `gemini-validate logic "reasoning"` - Check logic chains
- `gemini-validate ambiguity "A vs B"` - Resolve unclear choices
- `gemini-validate optimize "prompt"` - Reduce token usage

**User can request**: "validate this with Gemini" or "run a security check"

## Mandatory Validation Triggers (AUTOMATIC)
**Claude MUST use Bash tool to validate BEFORE proceeding**:
1. **Creating new scripts/tools** → `gemini-validate logic` (anti-fragmentation)
2. **Adding >50 lines** → `gemini-validate code` (security check)
3. **Architectural decisions** → `gemini-validate logic` (complexity audit)
4. **Performance claims** → `gemini-validate fact` (verify benchmarks)
5. **Multiple approaches** → `gemini-validate ambiguity` (choose best)

**Example Automatic Validation**:
```bash
# User: "Create a new script for backups"
# Claude detects: NEW TOOL trigger
# Claude runs via Bash tool:
gemini-validate logic "Should backup be separate tool or flag?
Option A: New backup.sh (150 lines)
Option B: Add --backup flag to existing tool (30 lines)"

# Gemini: "QUESTIONABLE - Need evaluation criteria"
# Claude: "Gemini suggests defining criteria before choosing approach"
```

## Integration Points
- Works with **Anti-Theatre Protocol**: Validates complexity before building
- Enhances **Anti-Fragmentation**: Checks integration vs separation
- Supports **Security-First**: Automatic code review before shipping
```

### Usage Patterns

**Automatic (Claude-initiated)**:
```
You: "Create a new monitoring script"
Claude: [Detects NEW TOOL trigger]
Claude: [Runs gemini-validate logic via Bash tool]
Claude: "Gemini suggests integrating into existing tool instead of separate script"
```

**Manual (User-requested)**:
```
You: "Validate this architecture with Gemini"
Claude: [Runs gemini-validate logic with your design options]
Claude: [Shows Gemini's verdict and recommendations]
```

**Direct (You run it)**:
```bash
gemini-validate code "$(cat my_script.sh)"
```

### Token Efficiency

**Without Integration** (Claude validates internally):
- Uses Claude's extended thinking: ~2000 tokens
- Uses Anthropic API quota
- Costs count toward your session budget

**With Integration** (Claude runs gemini-validate):
- Uses Bash tool: **0 Claude tokens**
- Uses Google API: ~$0.0001 per validation
- 2-3 second response time
- No impact on Claude session budget

**Example Savings**:
- 10 validations in session
- Without: 20,000 Claude tokens used
- With: 0 Claude tokens, $0.001 Google API cost

## Configuration

### API Key

Set your Google API key:
```bash
export GOOGLE_API_KEY="your-api-key-here"
```

Or add to `~/.bashrc`:
```bash
echo 'export GOOGLE_API_KEY="your-key"' >> ~/.bashrc
source ~/.bashrc
```

### Model Selection

- **FLASH** (default): Fast responses, good for most tasks
- **PRO**: More capable, slower, better for complex reasoning

```bash
gemini -m flash "Quick question"
gemini -m pro "Complex architectural design"
```

### Temperature Control

- **0.0**: Deterministic, factual
- **0.7**: Balanced (default)
- **0.9**: Creative, varied

```bash
gemini -t 0.0 "What is 2+2?"
gemini -t 0.9 "Write creative code comments"
```

## Advanced Features

### Conversation Continuity

```bash
gemini "Explain Docker containers"
gemini -c "How does it compare to VMs?"
gemini -c "Show me an example"
```

Conversation history stored in: `~/.gemini_conversation_history.json`

### Validation Logging

All validations logged to: `~/.gemini_validations.json`

```bash
# View recent validations
cat ~/.gemini_validations.json | jq '.[-5:]'
```

### Batch Validation

```bash
# Validate multiple files
for file in *.py; do
    echo "Validating $file..."
    gemini-validate code "$(cat "$file")"
done
```

## Success Metrics

**From monolith-updater project** (Oct 2025):
- 🔴 **Before Gemini**: Security rating 4/10 - command injection, missing error handling
- 🟢 **After Gemini**: Security rating 8/10 - 5 critical fixes applied
- ✅ **Result**: Shellcheck clean, production-ready

**16-Persona Validation**:
- Caught command injection in package handling
- Found insufficient error trapping
- Identified missing lock file management
- Flagged network retry gaps
- Recommended non-interactive mode

## Security Best Practices

### Don't Trust, Verify

```bash
# ❌ Bad: Ship without validation
claude "create update script" > update.sh && bash update.sh

# ✅ Good: Validate before running
claude "create update script" > update.sh
gemini-validate code "$(cat update.sh)"
# Review findings, apply fixes, then run
```

### Validate Claims with Evidence

```bash
# ❌ Bad: Accept performance claims
"This approach is 10x faster" → Ship it

# ✅ Good: Demand evidence
gemini-validate fact "This approach is 10x faster"
# Gemini: "No evidence provided, needs benchmarking"
```

### Check Logic Before Complex Decisions

```bash
# ❌ Bad: Make architectural decisions based on gut feeling
"This needs a separate microservice" → Build it

# ✅ Good: Validate reasoning
gemini-validate logic "This feature needs a separate microservice because..."
# Gemini: "Complexity not justified, integrate with flag instead"
```

## Troubleshooting

### Command Not Found

```bash
which gemini gemini-validate
# If empty, tools not in PATH
sudo cp gemini gemini-validate /usr/local/bin/
```

### API Key Issues

```bash
echo $GOOGLE_API_KEY
# If empty, key not set
export GOOGLE_API_KEY="your-key"
```

### Rate Limiting

Gemini API has rate limits. If you hit them:
- Wait 60 seconds between validation requests
- Use `-m flash` (faster, cheaper)
- Batch validations off-peak hours

## Anti-Theatre Protocol

**Reality Check Before Validation**:

1. **Evidence Required**: Don't validate claims without baseline measurements
2. **Necessity Check**: Is validation actually needed or just theatre?
3. **Action Focus**: Validation must lead to concrete action (fix/ship/reject)

**Red Flags**:
- ❌ Validating to delay shipping working code
- ❌ Over-validating trivial decisions (analysis paralysis)
- ❌ Validation without acting on results

**Validation is valuable when**:
- ✅ Shipping to production (security/correctness critical)
- ✅ Making architectural decisions (costly to reverse)
- ✅ Claims need evidence before sharing publicly

## Contributing

Found a bug or want to add a validation type? Open an issue or PR.

**New validation types must include**:
1. Clear use case and examples
2. Output format specification
3. Real-world validation proving value

## License

MIT License - See LICENSE file

## Credits

Built as part of the Monolith Protocol project, inspired by:
- Anti-Theatre Protocol (evidence-based development)
- Creator/Validator Architecture (dual-LLM validation)
- SOQM Philosophy (query efficiency)

---

**Version**: 1.0.0
**Last Updated**: October 2025
**Status**: Production Ready ✅
