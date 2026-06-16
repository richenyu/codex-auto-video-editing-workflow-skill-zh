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
4. 询问用户是否允许安装。
5. 用户同意后再运行 `scripts/setup-video-workflow.ps1`。

示例：

```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup-video-workflow.ps1 -DownloadFfmpeg -InstallPythonPackages -WithTranscription
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
