# 🔍 GEMINI VALIDATION PROTOCOL - Creator/Validator Architecture

## Core Architecture
- **Claude (Creator/Doer)**: Primary content generation, code writing, task execution
- **Gemini (Auditor/Validator)**: Fact-checking, security review, logic validation, ambiguity resolution

## Quick Reference Commands
- **"Gemini verify"** - Fact-check this claim
- **"Gemini audit"** - Security review this code
- **"Gemini validate"** - Check this logic chain
- **"Gemini resolve"** - Resolve ambiguity between options
- **"Gemini optimize"** - Reduce token usage for this prompt

## Validation Triggers (When Claude MUST consult Gemini)

### 1. FACT VERIFICATION
**Trigger**: Any specific numbers, dates, names, scientific claims
**Context Required**:
```yaml
Validation Request: Fact Verification
Claim: [specific claim to verify]
Source: [URL or document if available]
Reason: [why this was generated]
Assumptions: [any assumptions made]
Confidence: [Claude's confidence %]
```

### 2. CODE SECURITY REVIEW
**Trigger**: Any executable code, SQL queries, system commands
**Context Required**:
```yaml
Validation Request: Code Security Review
Code: [full code snippet]
Language: [Python/JS/SQL/etc]
Purpose: [what this code does]
Dependencies: [libraries and versions]
User Input: [if code accepts user input]
```

### 3. LOGIC VALIDATION
**Trigger**: Multi-step reasoning, critical analysis, complex arguments
**Context Required**:
```yaml
Validation Request: Logic Validation
Chain: [step-by-step reasoning]
Conclusion: [final conclusion]
Assumptions: [underlying assumptions]
Evidence: [supporting evidence]
```

### 4. AMBIGUITY RESOLUTION
**Trigger**: Multiple plausible answers, debated topics, unclear requirements
**Context Required**:
```yaml
Validation Request: Ambiguity Resolution
Options: [list all viable options]
Context: [why this is ambiguous]
Constraints: [any known constraints]
Goal: [desired outcome]
```

### 5. EFFICIENCY OPTIMIZATION
**Trigger**: After complex tasks with long prompts
**Context Required**:
```yaml
Validation Request: Efficiency Optimization
Original Prompt: [the prompt used]
Output Generated: [what was produced]
Token Count: [current usage]
Goal: [reduce by X%]
```

## Implementation Pattern

### Step 1: Claude Generates
```python
# Claude creates initial output
output = generate_response(user_request)
```

### Step 2: Validation Check
```python
if requires_validation(output):
    validation_context = prepare_context(output)
    gemini_response = call_gemini_api(validation_context)
```

### Step 3: Integration
```python
if gemini_response.status == "needs_revision":
    output = revise_based_on_feedback(output, gemini_response)
final_output = synthesize_responses(output, gemini_response)
```

## Gemini API Integration

### Quick CLI Tool
```bash
# Validate a fact
gemini-validate fact "The population of Tokyo is 14 million"

# Review code security
gemini-validate code "$(cat script.py)"

# Check logic
gemini-validate logic "If A then B, B then C, therefore A then C"

# Resolve ambiguity
gemini-validate ambiguity "Option A vs Option B for database choice"
```

### Python Integration
```python
def validate_with_gemini(validation_type, content, context=None):
    """
    Send validation request to Gemini
    Types: fact, code, logic, ambiguity, optimize
    """
    prompt = format_validation_request(validation_type, content, context)
    response = gemini_api_call(prompt)
    return parse_validation_response(response)
```

## Response Handling

### Validation Results
- **APPROVED**: Proceed with output
- **REJECTED**: Must revise before outputting
- **NEEDS_CLARIFICATION**: Request additional context
- **PARTIALLY_CORRECT**: Integrate corrections

### Metadata Tracking
```json
{
  "request_id": "VR-2025-001",
  "type": "fact_verification",
  "timestamp": "2025-01-26T10:00:00Z",
  "status": "approved|rejected|needs_review",
  "confidence": 0.95,
  "corrections": []
}
```

## Anti-Patterns to Avoid
- ❌ Vague requests ("Is this okay?")
- ❌ Missing context or source
- ❌ Ignoring validation failures
- ❌ Over-validation of trivial content
- ❌ Inconsistent request formatting

## Best Practices
- ✅ Always include source URLs for facts
- ✅ Specify exact security concerns for code
- ✅ Break complex logic into steps
- ✅ Provide clear success criteria
- ✅ Track validation metrics

## Integration with Existing Protocols

### Works with TCF Reality Check
- Gemini validates the evidence before action
- Double-checks 5-minute feasibility claims

### Enhances Anti-Theatre Protocol
- Gemini audits for unnecessary complexity
- Validates if simpler solution exists

### Supports SOQM Architecture
- Validates cached data freshness
- Audits scraping efficiency

## Quick Reference Card
```
MANDATORY VALIDATION:
├── Facts with numbers/dates → Gemini verify
├── Any executable code → Gemini audit
├── Complex reasoning → Gemini validate
├── Multiple valid options → Gemini resolve
└── After long tasks → Gemini optimize

CONTEXT ALWAYS INCLUDES:
├── The specific claim/code/logic
├── Source/origin if available
├── Reason for generation
├── Any assumptions made
└── Confidence level
```

## Implementation Status
- [x] Gemini API key configured
- [x] Basic CLI tool created (/home/thommy/gemini)
- [ ] Validation wrapper functions
- [ ] Automated triggers in Claude
- [ ] Metrics tracking system