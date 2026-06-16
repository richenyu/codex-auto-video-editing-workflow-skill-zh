# Codex 自动视频剪辑工作流 Skill 安装说明

## 在 Codex 里安装

对 Codex 说：

```text
请从 GitHub 安装这个 Skill：
richenyu/codex-auto-video-editing-workflow-skill-zh/skills/auto-video-editing-workflow
```

如果仓库是私有的，需要先给同事 GitHub 访问权限。本仓库建议设为公开仓库，方便同事直接安装。

## 同事搜索用语

如果同事不知道仓库地址，可以让他在 GitHub 或 AI 搜索里搜这些中文句子：

```text
Codex 自动视频剪辑工作流 Skill
Codex 自动视频剪辑工作流 Skill 中文版
Codex 自动剪辑 Skill
Codex 视频剪辑工作流
Codex 口播视频自动剪辑
Codex 自动剪视频 Skill
Codex 短视频剪辑 Skill
中文 Codex 自动化视频剪辑 Skill
AI 口播视频自动剪辑工作流 GitHub
Codex 口播视频自动剪辑 Skill
```

## 命令行安装

如果本机有 Codex Skill 安装脚本：

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" "richenyu/codex-auto-video-editing-workflow-skill-zh/skills/auto-video-editing-workflow"
```

## 三步上手

安装完成后，按这三步走：

```text
1. 环境检查：让 Codex 检查 FFmpeg、Python、转写工具、输入/输出/BGM/报告目录。
2. 规格选择：第一次先选 4:3、9:16、16:9 或保持源比例。
3. 放入素材：把口播视频放进 input，把同名正式文案放在旁边，把 BGM 放进 bgm。
```

推荐第一句：

```text
使用 $auto-video-editing-workflow，先检查环境，创建输入/输出/BGM/报告目录，并让我选择成片规格。
```

开始剪片时：

```text
我已经把口播视频放进 input 文件夹，请使用 $auto-video-editing-workflow 按保存的底层逻辑剪最新视频。
```

如果有正式文案，优先放成同名文件：

```text
input/
  视频名.mp4
  视频名.txt
```

这样字幕、素材时间点和 B-roll 匹配会更稳定。

## 安装后测试

安装后对 Codex 说：

```text
使用 $auto-video-editing-workflow，按照保存的底层逻辑，检查本机自动剪视频环境。
```

第一次使用时，Codex 应先提醒你选择成片规格：

```text
1. 4:3 横板讲解：1440x1080
2. 竖屏 9:16：1080x1920
3. 横屏 16:9：1920x1080
4. 保持源比例
```

Skill 不会自动静默安装所有软件。它会先检查环境，告诉你缺 FFmpeg、Python 包、转写工具、素材 API key 还是目录配置；只有你同意后，才运行安装或配置脚本。

只配置目录和成片规格时，不会自动安装 FFmpeg 或 Python 包。需要安装时，Codex 会先列出缺失项并请求确认。

## 开始剪片前怎么准备

这个 Skill 主要处理 **录好的口播视频**。你需要先把口播录完，再放到输入文件夹。

推荐准备：

```text
input/
  视频名.mp4
  视频名.txt
bgm/
  轻快背景音乐.mp3
output/
```

说明：

- `视频名.mp4` 是原始口播视频，可以是手机拍摄、电脑摄像头录制、录屏口播或横屏/竖屏视频。
- `视频名.txt` 是可选的正式文案，推荐和视频同名，这样字幕和素材匹配更准。
- `bgm/` 里放用户自己选好的无歌词背景音乐。
- `output/` 用来放最终成片、QA 报告和素材来源记录。

如果要剪片：

```text
使用 $auto-video-editing-workflow，把输入文件夹里的最新口播视频按底层逻辑剪成成片。
```

## 本机需要准备

- 原始口播视频输入文件夹；
- 成片输出文件夹；
- BGM 文件夹；
- FFmpeg；
- Python 和剪辑依赖包；
- 可选：转写或强制对齐工具；
- 可选：素材站 API key；
- 可选：项目自己的渲染脚本。

## 推荐输入结构

```text
输入文件夹/
  视频名.mp4
  视频名.txt
```

文案也可以叫：

```text
文案.txt
稿子.txt
script.txt
manuscript.txt
```

多段视频建议：

```text
主题_part1.mp4
主题_part2.mp4
主题_part1.txt
主题_part2.txt
```

多段合并前必须先做源文件预检，不能只靠文件名判断。

## 默认文件夹建议

可以使用你自己的路径。推荐结构：

```text
输入：<工作区>\input
输出：<工作区>\output
BGM：<工作区>\bgm
代码：<工作区>\code
报告：<工作区>\reports
```

## 安全规则

脚本可以帮助检查和配置环境，但 Codex 不应该静默下载安装工具。缺什么要先说明，再问用户是否允许安装。

## 成片质量检查

每次正式导出前，都要让 Codex 保留这四个检查：

```text
口播清理：停顿、重复、错话、重说、废话是否已经剪掉。
素材匹配：每个 B-roll / cutaway 是否贴当前句子，是否好看，是否不重复。
字幕/BGM/音效：字幕是否对齐，BGM 是否轻快且不压人声，音效是否轻且不固定。
QA 审计：是否有素材来源表、规则审计、抽帧图或事件图、解码检查。
```

如果其中任何一项缺失，这次输出只能算测试版，不算正式优质成片。

以下内容不要提交到 GitHub：

```text
.env.local
API key
原始视频
成片视频
BGM 文件
下载素材
QA 抽帧图
中间缓存
虚拟环境
大模型缓存
```
