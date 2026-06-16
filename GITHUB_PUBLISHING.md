# GitHub 发布说明

建议仓库：

```text
richenyu/codex-auto-video-editing-workflow-skill-zh
```

安装路径：

```text
richenyu/codex-auto-video-editing-workflow-skill-zh/skills/auto-video-editing-workflow
```

## 发布目标

这是纯中文版公开仓库，给中文用户和同事安装使用。英文用户使用英文版仓库：

```text
richenyu/codex-auto-video-editing-workflow-skill
```

## 公开名称

```text
Codex 自动视频剪辑工作流 Skill
```

## GitHub 描述建议

```text
Codex 自动视频剪辑工作流 Skill：中文 AI 自动化剪辑工作流，支持口播清理、重复话术删除、文案字幕对齐、BGM/音效、素材匹配、真实视频 cutaway、素材来源表和 QA 审计。
```

备选长描述：

```text
Codex 自动视频剪辑工作流 Skill：可从 GitHub 安装的中文 Codex Skill，用于财经、商业、AI、技术和知识类口播视频的自动化剪辑，覆盖顺稿去重、停顿删除、字幕文案对齐、BGM/音效、素材匹配、全屏插片和成片 QA。
```

## 推荐 Topics

```text
codex
codex-skill
video-editing
ai-video-editing
short-form-video
talking-head-video
workflow-automation
b-roll
captions
ffmpeg
creator-tools
finance-explainer
business-explainer
chinese-video
```

## 发布检查

- README 为中文。
- INSTALL 为中文。
- SEO 关键词为中文。
- SKILL.md 有中文触发词。
- references 中保留中文底层逻辑。
- `.gitignore` 排除原视频、成片、BGM、素材、缓存、密钥。
- 不提交 API key。
- 不提交用户原始视频。
- 不提交下载素材或成片。
- Skill frontmatter 只有 `name` 和 `description`。
