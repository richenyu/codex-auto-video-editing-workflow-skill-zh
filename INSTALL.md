# 安装说明

## 在 Codex 里安装

对 Codex 说：

```text
请从 GitHub 安装这个 Skill：
richenyu/codex-auto-video-editing-workflow-skill-zh/skills/auto-video-editing-workflow
```

如果仓库是私有的，需要先给同事 GitHub 访问权限。本仓库建议设为公开仓库，方便同事直接安装。

## 命令行安装

如果本机有 Codex Skill 安装脚本：

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" "richenyu/codex-auto-video-editing-workflow-skill-zh/skills/auto-video-editing-workflow"
```

## 安装后测试

安装后对 Codex 说：

```text
使用 $auto-video-editing-workflow，按照保存的底层逻辑，检查本机自动剪视频环境。
```

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
