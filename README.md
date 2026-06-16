# Codex 自动视频剪辑工作流 Skill

这是一个可安装到 Codex 的 **Codex 自动视频剪辑工作流 Skill**，用来让 Codex 按固定底层逻辑自动剪辑口播视频，把原始口播素材处理成适合发布的短视频成片。

它保存了自动化剪辑、口播清理、重复话术删除、停顿删除、文案字幕对齐、BGM、音效、素材匹配、真实视频 cutaway、动态信息贴片、素材来源记录和最终 QA 的底层逻辑。以后换新窗口或给同事使用时，不需要重新复制一长串提示词。

## 中文搜索摘要

**Codex 自动视频剪辑工作流 Skill** 是一个面向中文创作者的 AI 自动化剪辑工作流。它适合用来处理财经口播、商业解释、AI 创业、技术教程、美股分析、知识分享和短视频批量生产场景，核心目标是让 Codex 自动完成“顺稿、剪停顿、删重复、对齐字幕、匹配素材、加 BGM 音效、导出成片、做质量检查”这一整套流程。

## 适合谁

- 做财经、美股、商业、AI、技术解释类短视频的创作者；
- 有大量口播原片，需要自动剪掉停顿、重复、错话的人；
- 想让 Codex 按固定底层逻辑剪视频的人；
- 想把剪辑流程交给同事，但不想每次重新训练规则的人；
- 需要素材、字幕、配乐、音效、QA 一套流程的人。

## 它能做什么

- 安装后先做环境检查和首次使用向导；
- 提醒用户选择 4:3、9:16、16:9 或保持源比例；
- 自动找到输入文件夹里的最新口播视频；
- 多段视频合并前做预检，防止把错误主题混进去；
- 先清理口播，再加素材；
- 删除停顿、重说、错话、半句话、重复观点；
- 使用用户提供的正式文案校准字幕和素材节奏；
- 默认清理后 1.2 倍语速，保持音高；
- 默认导出 4:3，1440x1080，30fps；
- 支持用户指定竖屏 9:16 或横屏 16:9；
- 默认加字幕、轻快 BGM、轻音效；
- 按句子级匹配寻找或生成素材；
- 真实视频、录屏、电影感动图、全屏 cutaway、动态信息贴片混合使用；
- 拒绝素材重复、弱匹配素材、难看素材、PPT 感太重的素材；
- 生成素材来源表、规则审计、抽帧 QA。

## 当前默认风格

```text
成片比例：首次使用先选择；未选择时才默认 4:3
4:3 分辨率：1440x1080
9:16 分辨率：1080x1920
16:9 分辨率：1920x1080
帧率：30fps
格式：MP4
语速：口播清理后 1.2 倍
字幕：默认内嵌
BGM：默认轻快、正向、低音量
音效：默认轻量、变化、不固定
```

2 分钟左右的财经、商业、技术解释视频，默认节奏：

```text
真人可见：约 45%-55%
素材主导：约 45%-55%
全屏真实或视频化 cutaway：通常 5-7 个
真人段落动态信息贴片：约 8-14 个
```

## 不能妥协的规则

- 先清理口播，再加素材。
- 不能用 B-roll、音乐、音效掩盖口播重复。
- 同一个素材不能在一条视频里重复出现。
- 不能把弱素材包硬塞进成片。
- 不能把 PPT MP4 当成真实视频 cutaway。
- 不能用泛 AI、泛商业、泛财经素材硬凑。
- 素材必须同时好看且匹配当前句子。
- 正式成片默认要字幕、BGM、音效和 QA。
- 素材站/API 结果只是候选池，不能直接进时间线。
- 多段视频必须先检查，不允许混错源文件。

## 安装

在 Codex 里说：

```text
请从 GitHub 安装这个 Skill：
richenyu/codex-auto-video-editing-workflow-skill-zh/skills/auto-video-editing-workflow
```

如果你的 Codex 环境支持安装脚本，也可以运行：

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" "richenyu/codex-auto-video-editing-workflow-skill-zh/skills/auto-video-editing-workflow"
```

## 安装后第一句话

```text
使用 $auto-video-editing-workflow，按照保存的底层逻辑，把输入文件夹里的最新口播视频剪成成片。如果本机缺工具或路径，请先检查环境，不要直接静默安装。
```

首次使用建议先说：

```text
使用 $auto-video-editing-workflow，先检查自动剪视频环境，并让我选择成片规格：4:3、9:16、16:9 或保持源比例。
```

## 仓库结构

```text
skills/auto-video-editing-workflow/
  SKILL.md
  agents/openai.yaml
  references/
    workflow.md
    style-rules.md
    bottom-logic.md
    finance-explainer.md
    local-setup.md
    non-regression-checklist.md
  scripts/
    check-video-workflow.ps1
    setup-video-workflow.ps1
```

## 边界

这个仓库是 Codex Skill，不是独立视频编辑软件。它提供工作流、规则、检查脚本和决策逻辑。真正出片仍需要本机有输入/输出文件夹、FFmpeg、Python 包、可选转写工具、BGM、素材和渲染脚本。

## SEO 关键词

Codex 自动视频剪辑工作流 Skill、Codex 自动视频剪辑、Codex 自动化剪辑、AI 自动剪视频、口播视频自动剪辑、短视频自动化剪辑、自动剪掉重复话术、自动删除口播停顿、文案字幕自动对齐、自动加字幕 BGM 音效、财经口播剪辑、商业解释视频剪辑、技术教程视频剪辑、素材自动匹配、真实视频素材 cutaway、动态信息贴片、4:3 短视频剪辑、中文 Codex Skill、可安装 Codex 工作流。

更多关键词布局见 [SEO_KEYWORDS.md](SEO_KEYWORDS.md)。
