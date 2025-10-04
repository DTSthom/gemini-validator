# Claude Code Integration Template

Copy this section to your `~/.claude/CLAUDE.md` to enable automatic Gemini validation.

---

## 🔍 GEMINI VALIDATION PROTOCOL (Creator/Validator Architecture)
**Claude = Creator/Doer | Gemini = Auditor/Validator**

**🚀 ZERO TOKEN USAGE**: Claude uses Bash tool to run validations outside session

### Quick Commands (Claude runs via Bash tool)
- `gemini-validate fact "claim"` - Verify facts/numbers/dates
- `gemini-validate code "$(cat file.py)"` - Security review code
- `gemini-validate logic "reasoning"` - Check logic chains
- `gemini-validate ambiguity "A vs B"` - Resolve unclear choices
- `gemini-validate optimize "prompt"` - Reduce token usage

**User can request manually**: "validate this with Gemini" or "run a security check"

### Mandatory Validation Triggers (AUTOMATIC)
**Claude MUST use Bash tool to validate BEFORE proceeding**:
1. **Creating new scripts/tools** → `gemini-validate logic` (anti-fragmentation)
2. **Adding >50 lines** → `gemini-validate code` (security check)
3. **Architectural decisions** → `gemini-validate logic` (complexity audit)
4. **Performance claims** → `gemini-validate fact` (verify benchmarks)
5. **Multiple approaches** → `gemini-validate ambiguity` (choose best)

### Example Automatic Validation

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

### Integration Points
- Works with **Anti-Theatre Protocol**: Validates complexity before building
- Enhances **Anti-Fragmentation**: Checks integration vs separation
- Supports **Security-First**: Automatic code review before shipping

### Token Efficiency Benefits

**Without Integration** (Claude validates internally):
- Uses Claude's extended thinking: ~2000 tokens per validation
- Uses Anthropic API quota
- Counts toward your 200K session budget

**With Integration** (Claude runs gemini-validate):
- Uses Bash tool: **0 Claude tokens**
- Uses Google API: ~$0.0001 per validation
- 2-3 second response time
- No impact on Claude session budget

**Example Savings**:
- 10 validations in a session
- Without: 20,000 Claude tokens used (10% of budget)
- With: 0 Claude tokens, $0.001 Google API cost

---

## Installation

If you haven't installed gemini-validator yet:

```bash
git clone https://github.com/DTSthom/gemini-validator.git
cd gemini-validator
./install.sh
```

Set your Google API key (get one at https://aistudio.google.com/app/apikey):

```bash
export GOOGLE_API_KEY="your-api-key-here"
echo 'export GOOGLE_API_KEY="your-api-key-here"' >> ~/.bashrc
```

Test the integration:

```bash
gemini-validate fact "Python was released in 1991"
```
