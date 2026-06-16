# 本机配置

这个 Skill 可以在不同电脑上使用，路径按本机配置。

## 推荐目录

```text
自动剪视频工作区/
  input/
  output/
  bgm/
  assets/
  stock-cache/
  reports/
  code/
```

## 需要配置

```text
原始口播输入目录
成片输出目录
BGM 目录
项目代码目录
素材缓存目录
报告目录
```

## 新电脑启动流程

1. 读取 `SKILL.md`、`references/workflow.md`、`references/local-setup.md`。
2. 运行 `scripts/check-video-workflow.ps1` 检查环境。
3. 报告缺少的工具、目录或脚本。
4. 先解释：Skill 不会静默安装软件；只有用户同意后，才下载 FFmpeg、安装 Python 包或配置转写工具。
5. 询问首次使用规格选择：4:3、竖屏 9:16、横屏 16:9、保持源比例。
6. 用户同意后再运行 `scripts/setup-video-workflow.ps1`，并把规格写入 `workflow-config.json`。

## 三步上手

给新同事或新电脑使用时，按固定三步引导：

```text
1. 检查环境和目录：input、output、bgm、assets、reports、FFmpeg、Python、转写/对齐工具。
2. 选择成片规格：4:3、9:16、16:9 或保持源比例，并写入 workflow-config.json。
3. 放入素材开剪：口播视频放 input，同名正式文案放 input，BGM 放 bgm，再剪最新视频。
```

推荐第一次提示词：

```text
使用 $auto-video-editing-workflow，先检查环境，创建输入/输出/BGM/报告目录，并让我选择成片规格。
```

推荐剪片提示词：

```text
我已经把口播视频放进 input 文件夹，请使用 $auto-video-editing-workflow 按保存的底层逻辑剪最新视频。
```

## 首次使用向导

安装后第一次使用必须提醒用户选择视频规格，不能默认套用某一个人的参数。

```text
1. 4:3 横板讲解：1440x1080，适合小林说式讲解、财经/商业/技术解释。
2. 竖屏 9:16：1080x1920，适合抖音、视频号、小红书、TikTok、Reels。
3. 横屏 16:9：1920x1080，适合 B 站、YouTube、课程、横屏教程。
4. 保持源比例：适合已经设计好画幅的素材，只做口播清理和包装。
```

用户没有选择时，先问一次；如果用户仍让 Codex 自己决定，才按内容和源视频自动判断，默认优先 4:3。

示例：

```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup-video-workflow.ps1 -TargetProfile ask -DownloadFfmpeg -InstallPythonPackages -WithTranscription
```

如果只想先配置目录和成片规格，不安装软件：

```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup-video-workflow.ps1 -TargetProfile ask
```

如果只想创建 Python 虚拟环境但暂不装包：

```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup-video-workflow.ps1 -TargetProfile 4x3 -CreateVenv
```

## 常用工具

```text
ffmpeg
ffprobe
python
moviepy
opencv
auto-editor
转写或强制对齐工具
```

## BGM

使用用户放在 BGM 目录里的无歌词音乐。不要固定调用旧的生成音乐。

如果 BGM 目录为空，询问用户添加音乐或导出无 BGM 版本。

## 首次质量提示

正式出片前提醒用户：本工作流默认会做口播清理、素材匹配、字幕/BGM/音效和 QA 审计。缺任一项时只交付测试版，不标记为正式优质成片。
