# 非回归检查清单

这个清单防止新规则把旧规则忘掉。它是交付门槛，不是提醒。

## 规则栈原则

用户新增反馈时：

```text
1. 说明旧规则哪些继续有效。
2. 说明新规则改变什么行为。
3. 把新规则变成可检查的 QA 项。
4. 写入底层逻辑或 Skill 引用文件。
5. 下次交付前用审计字段验证。
```

## 锁定规则

正式口播剪辑默认必须保留：

```text
先清理口播
清理后默认 1.2 倍语速
正式成片默认字幕/BGM/音效
BGM 来自用户指定目录
素材同时好看且匹配
素材必须句子级匹配
同一成片素材不能重复
静态图必须视频化
禁止贴脸小贴纸
真人段落保留中大号动态信息贴片
真实或视频化素材优先
真人/素材节奏平衡
全屏 cutaway 目标数量
观点卡不能冒充真实 cutaway
有用时允许 1/2/3 素材同屏但要有主次
音效不能固定重复
必要时背景虚化或变暗
不能出现可见的“模仿某博主风格”标签
必须有抽帧/解码 QA
```

## 必须审计字段

```text
speech_cleanup_pass
speech_speed_multiplier
captions_enabled
bgm_path
sfx_event_count
beauty_relevance_gate_pass
material_match_gate_pass
low_match_material_count
unique_material_asset_count
reused_material_asset_count
visual_similarity_duplication_count
static_image_only_count
dynamic_material_count
speaker_visible_ratio
material_dominant_ratio
full_broll_count
video_like_cutaway_count
content_motion_overlay_count
multi_material_layout_count
tiny_sticker_violation_count
ppt_like_material_violation_count
caption_face_overlap_pass
decode_pass
contact_sheet_path
```

## 失败示例

以下情况不能交付正式版：

- 新视觉风格导致动态贴片消失；
- 全屏素材增加了，但全片变成静态图推拉；
- 加了素材却把口播重复保留下来；
- 贴片变成小标签贴脸；
- BGM 又用了用户已经否定的旧音乐；
- 同一素材或同一视觉模板反复出现；
- 素材只跟大主题相关，不贴当前句子；
- 字幕和声音对不上；
- 多段视频混错主题。
