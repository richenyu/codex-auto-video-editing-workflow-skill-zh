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
