  # Codex 协作规则

  ## 回复约定
  - 默认使用简体中文回答，除非我明确要求英文
  - 修改代码前，先用 1 到 3 句话简要说明思路
  - 优先给出可直接执行的命令
  - 回答保持简洁，必要时再展开
  - 不要输出空泛建议，尽量给出可落地方案

  ## 代码修改约定
  - 优先保持现有项目结构与命名风格一致
  - 非必要不要做大范围重构
  - 修改时尽量只改和当前任务相关的内容
  - 不要随意删除已有注释、文档注释或用户手动调整的代码

  ## 代码风格
  - 方法、字段尽量使用文档注释
  - 一般使用中文注释
  - 中文注释末尾不添加句号
  - 注释尽量说明业务意图，不写无意义注释
  - 新增代码风格尽量与周围代码保持一致

  ## 变更说明
  - 完成修改后，简要说明改动内容、影响范围和验证方式
  - 如果未验证或无法验证，需要明确说明

@/home/daguo/.codex/RTK.md

<!-- context7 -->
Use the `ctx7` CLI to fetch current documentation whenever the user asks about a library, framework, SDK, API, CLI tool, or cloud service -- even well-known ones like React, Next.js, Prisma, Express, Tailwind, Django, or Spring Boot. This includes API syntax, configuration, version migration, library-specific debugging, setup instructions, and CLI tool usage. Use even when you think you know the answer -- your training data may not reflect recent changes. Prefer this over web search for library docs.

Do not use for: refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.

## Steps

1. Resolve library: `npx ctx7@latest library <name> "<user's question>"` — use the official library name with proper punctuation (e.g., "Next.js" not "nextjs", "Customer.io" not "customerio", "Three.js" not "threejs")
2. Pick the best match (ID format: `/org/project`) by: exact name match, description relevance, code snippet count, source reputation (High/Medium preferred), and benchmark score (higher is better). If results don't look right, try alternate names or queries (e.g., "next.js" not "nextjs", or rephrase the question)
3. Fetch docs: `npx ctx7@latest docs <libraryId> "<user's question>"`
4. If you weren't satisfied with the answer, re-run the same command with `--research`. This retries with sandboxed agents that git-pull the actual source repos plus a live web search, then synthesizes a fresh answer. More costly than the default
5. Answer using the fetched documentation

You MUST call `library` first to get a valid ID unless the user provides one directly in `/org/project` format. Use the user's full question as the query -- specific and detailed queries return better results than vague single words. Do not run more than 3 commands per question. Do not include sensitive information (API keys, passwords, credentials) in queries.

For version-specific docs, use `/org/project/version` from the `library` output (e.g., `/vercel/next.js/v14.3.0`).

If a command fails with a quota error, inform the user and suggest `npx ctx7@latest login` or setting `CONTEXT7_API_KEY` env var for higher limits. Do not silently fall back to training data.
Run Context7 CLI requests outside Codex's default sandbox. If a Context7 CLI command fails with DNS or network errors such as ENOTFOUND, host resolution failures, or fetch failed, rerun it outside the sandbox instead of retrying inside the sandbox.
<!-- context7 -->
