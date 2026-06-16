# 自动剪视频当前采用底层逻辑

更新时间：2026-06-13

这是当前唯一采用的自动口播短视频剪辑工作流。旧聊天里的临时规则、旧成片样式、旧参数如果与本文件冲突，一律以本文件为准。

## 新窗口恢复

新窗口遇到这些请求时，必须调用本逻辑：

```text
帮我剪最新视频
按之前底层逻辑剪
自动剪口播
剪财经/美股/商业解释视频
生成类似小林说节奏的视频
做完整发布版
```

优先读取：

```text
D:\CodecX全项目管理\P08_C02_自动剪视频_auto_video_editing\08_短视频自动剪辑底层逻辑_video_editing_logic.md
C:\Users\进步\.codex\skills\auto-video-editing-workflow\SKILL.md
C:\Users\进步\.codex\skills\auto-video-editing-workflow\references\style-rules.md
C:\Users\进步\.codex\skills\auto-video-editing-workflow\references\finance-explainer.md
C:\Users\进步\.codex\skills\auto-video-editing-workflow\references\local-setup.md
```

## 路径

```text
原始口播输入：D:\自动剪视频口播
用户成片输出：D:\自动剪视频成片
默认 BGM：D:\自动剪视频BGM
项目代码：D:\CodecX全项目管理\P08_C02_自动剪视频_auto_video_editing\50_代码_code\auto_talk_cut_mvp
```

用户说“最新视频”时，默认从 `D:\自动剪视频口播` 按 LastWriteTime 取最新视频，不要拿旧输出目录里的历史文件。

## 总流程

```text
1. 定位最新原始口播。
2. 转写并理解主题、受众、主线和关键词。
3. 先顺稿，再剪片：删除重复、错话重来、半句起头、低信息复述、长停顿。
4. 建立干净自然的人声时间线。
5. 再匹配或生成素材，素材必须同时通过“美观”和“匹配”双门槛。
6. 按 face / overlay / feature / full_card / full_broll 混合布局。
7. 加真实全屏插片 cutaway，默认每分钟约 3 个。
8. 加轻音效，音效要变化，不固定重复。
9. 正式发布版默认加字幕和明亮正能量 BGM。
10. QA 通过后复制到 D:\自动剪视频成片。
```

素材、动效、音乐不能用来掩盖口播不顺。口播本身必须先剪顺。

## 口播清理

短视频必须持续有人声推进。以下默认剪掉：

- 长停顿、想词、等待、卡住、无声音空白。
- 起头废句：前一句刚起头，后一句完整重说。
- 说错重来：保留改正后的句子。
- 同一观点重复：保留信息量更高、更完整、更顺的一版。
- 低新增信息复述：前面已经讲清，后面没有新数字、新原因、新判断。
- 句内重复启动：例如“市场，市场……”“油价，油价……”“QQQ/SPY，QQQ/SPY/SMH……”

财经词必须先做 ASR 纠错和归一，例如：

```text
纳纸/纳指、气货/期货、邮价/油价、通脏/通胀、每年处/美联储、
分显平耗/风险偏好、半逃底/半导体、QQQ/SPY/SMH/NVDA/AVGO/MRVL/AMD
```

有正式文案时，进入“参考文案软对齐”：

- 文案是保留/删除的最高参考，但不能机械逐字碎切。
- 先自然口播分段，再按正式文案顺序软对齐。
- 对同一 segment 内的重复启动做局部修剪。
- 低置信匹配不能大跨度跳跃，避免误删正文。
- 最终听感必须像自然连续口播。

## 字幕

当前采用：正式发布版默认烧字幕。

- 字幕来自清理后的口播时间线或正式文案，不用原始未清理 ASR。
- 1-2 行为主，粗体白字或黄字，深色描边/阴影。
- 避开人物嘴、眼睛、重要素材文字。
- 全屏素材有关键文字时，字幕上移、缩短或短暂隐藏。
- 用户明确说“剪映做字幕/无字幕版/干净版”时，再导出无硬字幕版本。

## 音乐

当前采用：正式发布版默认加低音量、无歌词、明亮正能量 BGM。

情绪目标：

```text
轻快、欢快、明亮、正能量、赚钱动力、往上走、干净、自信
```

拒绝：

```text
压抑、冷、黑暗、悬疑、坏消息感、低频太重、新闻危机感、抢人声
```

默认 BGM 选择：

```text
只从 D:\自动剪视频BGM 中用户当前放入的音乐文件选择。
不要再调用我之前生成的固定三首或旧三首。
如果文件夹为空，不要编造默认音乐；先提醒用户放入 BGM，或导出无 BGM 版本。
```

旧生成的 BGM 用户反馈不合适，已从默认库中删除，不再作为任何主题的默认 fallback。

BGM 必须低于人声，淡入淡出。人声环境噪声明显时，继续降低 BGM。

## 音效

音效默认加，但必须轻、准、变化。

- 不固定一种声音重复。
- 不按固定间隔触发。
- 只在素材入场、全屏插片、重点转折、放大卡出现时触发。
- 混合 `click / tap / whoosh / soft_hit / shine`。
- 音效总量少于视觉变化数。
- 低于人声，不刺耳，不爆音。

## 素材双门槛

素材必须同时满足：

```text
1. 美观：清晰、漂亮、构图好、现代、干净、不廉价、手机上可读。
2. 匹配：与正在说的句子、公司、产品、市场、地点、类比、数据点直接相关。
```

相关但丑：换源、重裁、重设计、动画化或生成更干净版本。
好看但不相关：不用。

避免：

- 模糊、低清、脏乱、乱裁切、水印、随机图库感。
- 文字太小看不清。
- 通用股票背景硬套所有财经话题。
- 旧视频素材或其他主题素材乱塞。

## 本地素材包不是硬约束

本地素材包只能作为候选库，不能作为必须使用的素材来源。素材包没做好、模板感重、像 PPT、主题不贴、颜色丑、低清、重复、或者和当前文案弱相关时，必须主动放弃，不要硬套。

硬规则：

```text
1. 使用本地素材包前，先做素材包预审：逐项判断是否同时通过“美观”和“句子级匹配”。
2. 素材包资产如果是 PPT/模板/假 UI/卡片循环/弱相关视频，即使是 MP4，也不能算优质真实素材。
3. 素材包不合格时，不要为了省时间硬用；优先去素材网站、官方网页/公开视频、产品官网、真实录屏、行情/数据录屏、用户自有素材里重新找。
4. 可用素材站/API 优先级：授权 stock video/图片、官方公开素材、可商用免费素材、真实网页录屏、AI 视频生成。
5. 不允许把“只有一个素材包”当成限制条件。素材质量不行就扩大来源，不能让差素材决定成片质感。
6. 如果素材站需要账号/API key，而当前不可用，必须明确标注“素材不足/试剪版”，不能假装本地素材包已经足够。
7. 规则审计必须记录：local_pack_assets_used、local_pack_assets_rejected、external_stock_needed、external_stock_used、fallback_reason。
```

执行顺序：

```text
1. 按文案拆素材需求。
2. 先搜本地素材包是否有强匹配且好看的资产。
3. 本地资产不达标，立刻转外部素材站/官方素材/真实录屏/AI 视频生成。
4. 外部素材也暂时拿不到，才用高质量中文信息板或电影感强运动兜底，并标记为试剪/过渡版。
```

## 生成式真实场景素材

当官方页面、真实照片、短视频、动图或录屏不够时，可以主动生成符合文案的照片感/场景感素材，但“生成素材”不等于继续做 PPT 卡。

优先生成：

- 科技/AI：真实电脑桌面、产品使用场景、代码屏幕、服务器机房、办公室协作、城市科技感场景。
- 财经/商业：交易屏幕、办公室、公司大楼、会议场景、数据大屏、市场情绪、投资者观察市场的画面。
- 本地服务/创业：门店、客户沟通、工具使用、工人/创业者工作场景、报价/交付现场。
- 文案类比：把“病人坐起来”“跑马拉松”“市场松一口气”等比喻转成具体画面，而不是做文字卡。

生成画面必须：

- 像照片、电影截图、真实场景、产品展示或视频 cutaway，而不是平面 PPT/海报。
- 与当前句子直接匹配，画面里有明确主体、动作或场景。
- 做成大图、全屏插片、局部推拉、轻微镜头运动或短视频化处理。

避免：

- 只有大字、图标、箭头、渐变背景的解释卡反复出现。
- 一个模板换几次文字就当多张素材。
- 随机科技背景、随机金融图、随机办公室图硬套文案。
- AI 生成痕迹明显、手脸畸形、文字乱码、廉价海报感。

照片感/场景感生成素材如果足够大、足够美观、与文案强匹配，并做了镜头运动，可以作为 `full_broll/cutaway` 计入全屏插片；纯标题卡、观点卡、图表卡仍然只算 `full_card`，不能冒充真实/视频化插片。

## 高级电影感财经/科技素材方向

用户给的参考博主截图，重点学习其“高级配图方法”，不能复制其账号、头像、封面文字、具体画面、口头包装或品牌识别。

可蒸馏的方法：

- 每个强素材必须有一个明确主视觉：公司大楼、产品、交易屏幕、城市、人物背影、机械设备、数据大屏、产业现场、具体类比场景。
- 画面要像专业封面/电影截图/高端纪录片插片，而不是模板图、PPT 背景或随机图库图。
- 构图要有层次：前景主体 + 中景信息 + 背景环境，允许暗色氛围、侧逆光、局部高光、红/青/金等点缀色，但不能脏、糊、乱。
- 文字不要生成在图片里。AI 生成图尽量无文字、无假 logo、无水印；需要标题时，后期用清晰大字叠加。
- 财经/商业主题要有行业隐喻：房价可用城市、楼盘、观察市场的人；资本可用舞台、交易屏、资金流；AI/科技可用产品、芯片、机房、办公屏幕。
- 口播视频里，参考风格主要用在每分钟约 3 个全屏插片，以及少量 60%-75% 大块 feature 资料镜头；不要把整条视频做成封面轮播。
- 首要标准是好看，第二标准是匹配；丑的真实素材不能凑数，宁愿换源、重裁、生成更好的场景图或少用。

生成/筛选素材时默认给自己加审美提示：

```text
poster-grade, cinematic editorial visual, premium finance/technology documentary style,
strong main subject, dramatic but clean lighting, depth, high contrast, polished composition,
no text in image, no watermark, no fake UI text, no deformed hands/faces, phone-readable framing
```

## 视觉布局

混合使用：

```text
face       -> 真人口播，信任、情绪、承接
overlay    -> 中/大信息层，不能是贴脸小标签或廉价小贴纸
feature    -> 大资料画面，真人仍存在
full_card  -> 全屏解释卡/图表/观点卡
full_broll -> 真实全屏插片/cutaway，真人可被完全遮住，声音继续
```

不要全片像 PPT。财经/商业/技术解释视频必须混合真人、真实照片/视频/动图/网页/截图/图表/解释卡。

## 禁止小贴纸式文字标签

用户明确否定贴在人脸附近的小 pill 标签、小贴纸、小碎片文字条。以后不能用这种东西当“小特效”或“插图”。

禁止：

- 小 pill 标签、小气泡、小碎片文字条贴在人脸、眼睛、鼻子、嘴附近。
- 在画面上漂几个小标签就当成动态设计。
- 用小标签替代真正的大块资料、动图、视频、截图或解释卡。

正确做法：

- 要么保持干净真人画面。
- 要么做大块漂亮资料层：大卡、半屏资料、feature 大图、全屏 `full_broll/cutaway`。
- 要么做视频化素材：网页滚动、软件界面操作、图表动效、鼠标移动、局部推拉、GIF/短视频、流程演示。

## 大块资料动态化和多资料同屏

大块资料镜头不应只是静态卡。能做成动画、动图、短视频、界面滚动、图表动效、局部推拉时，优先动态化。

多资料规则：

- 大块资料镜头允许 1/2/3 个资料元素同屏，按句意和节奏选择。
- 2 个资料适合左右对比、前后对比、问题/答案、产品界面 + 商业结果。
- 3 个资料只用于关键总结、流程三步、证据堆叠，必须有一个明确主视觉。
- 同屏多资料必须仍然大块、漂亮、可读；不能变成小贴纸、小标签、小药丸文字。
- 主资料通常占 60%-75%，辅助资料占 25%-40%；空间不够时优先切全屏资料镜头。
- 多资料也要尽量视频化：同步滚动、逐项点亮、对比切换、数字跳动、主图推拉、局部细节放大。

## 全屏真实素材密度

当前采用：成熟解释型短视频默认每分钟约 3 个真实全屏 cutaway。

```text
30 秒以内：通常 1 个
30-60 秒：通常 2-3 个
60-180 秒：约 3 个/分钟
2 分钟左右财经/商业/技术视频：通常 5-7 个，默认目标 6 个
```

不是机械每 20 秒一个，要按内容节点：

- 公司/产品：公司楼、Logo、官网、财报页、产品图。
- 市场/行情：交易所、行情屏、指数/ETF 图表。
- 油价/能源：油井、油轮、能源图、地图。
- AI/芯片：GPU、服务器、数据中心、芯片、公司标识。
- 类比：餐厅、飞机、医院、工厂、账本、现金流等真实场景。

全屏素材每个默认 1-3 秒，总时长约占全片 8%-18%。宁可少用，也不要塞无关或丑素材。

## 财经/商业解释风格

可以学习“小林说”类财经解释的抽象方法：

- 问题导向开头。
- 故事化解释。
- 因果链图解。
- 数据可视化。
- 真实资料截图。
- 章节化推进。
- 结尾给观察框架。

不能复制她的具体素材、音乐、包装、标题样式、口头禅或频道标签。视频里禁止出现“小林式”“某某式”“模仿某博主”等可见字样。

财经解释结构：

```text
钩子 -> 事实 -> 原因链 -> 影响 -> 风险 -> 观察信号 -> 收尾判断
```

## 技术教程风格

技术类不能做成幻灯片轮播。优先：

- 真实/模拟录屏。
- 网页/GitHub 滚动。
- 鼠标移动、点击、配置填写。
- 代码输入、终端运行。
- 高亮框移动、界面切换。

静态卡只能做辅助，不能成为全片主体。

## 背景

真人口播默认做轻度背景虚化/压暗，保持脸、眼睛、嘴和表情清楚。背景虚化用于降低干扰，不是把人抠坏。

## QA

正式交付前必须检查：

- ffprobe：1080x1920、30fps、音视频流正常。
- ffmpeg 全解码无错误。
- volumedetect：无爆音，BGM/SFX 不盖人声。
- 抽帧：字幕不挡嘴、不挡眼、不挡重要素材文字。
- 抽帧：素材美观且匹配，不像廉价 PPT。
- 抽帧：2 分钟左右视频有约 5-7 个真实全屏 cutaway。
- 抽帧：不能出现小 pill 标签、小贴纸、小碎片文字贴脸或遮挡五官。
- 播放检查：大块资料不能大部分只是静态幻灯片，要有视频感、推拉、高亮、滚动或动效。
- 版式检查：适合对比/流程/证据堆叠的段落，应有 2/3 个大块资料同屏的变化；但必须主次清楚、可读、不拥挤。
- 检查无可见“某某式/模仿某博主”标签。
- 检查布局不是固定模板重复。
- 检查音效不固定、不刺耳。

## 当前废弃规则

以下旧规则已废弃，除非用户本次明确要求：

- “字幕默认交给剪映”：已废弃。现在正式发布版默认加字幕。
- “BGM 默认不加”：已废弃。现在正式发布版默认加明亮低音量 BGM。
- “2 分钟财经视频至少 3 个全屏插片”：已废弃。现在默认 5-7 个，目标约 6 个。
- “使用我生成的固定三首 BGM”：已废弃。现在只调用用户放入 `D:\自动剪视频BGM` 的音乐。
- “全片真人 + 小卡片就够”：已废弃，必须加入真实/视频化素材和全屏 cutaway。
- “小 pill 标签/小贴纸可以当动态小特效”：已废弃，用户明确否定，会影响人物形象。
- “大块资料只能一次放一个静态图”：已废弃，可以做动画/动图/视频化资料，也可以 2/3 个同屏但必须有主次。

## 2026-06-13 追加更新：真人/素材 50-50 与视频化插片优先

用户最新纠正：上一版素材审美更好，但仍偏“图”和“静态展示”，真人出现比例也过高或过低都会影响节奏。后续自动剪辑要把成熟口播解释视频理解为“真人信任感 + 素材证据感”共同推进。

硬规则：

```text
1. 1-3 分钟口播解释视频，默认目标是真人可见时间约 45%-55%，素材主导时间约 45%-55%。
2. 素材主导时间包含 full_broll、视频化 cutaway、屏录、动图、动态照片、网页/图表动效和大块 feature。
3. 全屏素材可以完全遮住真人，真人声音继续讲；不要害怕切走人物。
4. 穿插素材优先是几秒的视频化片段；如果源素材是照片或生成图，也必须加推拉、摇移、扫光、局部放大、数据层运动等，让播放时像短视频，不像幻灯片。
5. 真人段仍要有内容型动态贴片：大号、漂亮、可读、和当前句子匹配，位置和大小变化，避开脸、嘴和字幕区。
6. 内容型动态贴片不是小 pill 标签、小贴纸、小碎片文字；如果变成贴脸碎片，QA 失败。
7. 一条成片不能只剩全屏素材，也不能只剩真人加少量装饰；两者要形成节奏交替。
8. 规则审计必须记录 speaker_visible_ratio、material_dominant_ratio、video_like_cutaway_count、content_motion_overlay_count。
```

执行建议：

```text
开头 1-3 秒保留真人或强钩子素材；
之后按语义节点频繁穿插 2-4 秒视频化素材；
每 8-15 秒回到真人建立信任和承接；
真人段用 1 个大号动态贴片增强重点，适合对比时可用 2 个，三贴片只用于总结且必须有主次。
```

## 2026-06-14 反遗忘与非回归审计机制

用户确认：如果训练出新东西以后旧规则被忘掉，就无法真正优化产品。后续自动剪视频必须把“规则不遗忘”当成产品机制，而不是临场记忆。

核心原则：

```text
1. 新规则只能叠加，不能覆盖旧规则。
2. 只有用户明确说某条旧规则废弃/取消/不要了，才能删除或降级该规则。
3. 每个新纠正必须写成可审计字段，不能只写成风格偏好。
4. 每次正式成片都必须做非回归审计：检查旧规则是否仍然保留。
5. 如果新风格导致旧规则失效，视为 QA 失败，不交付。
```

必须保留的锁定规则包括：

```text
speech_cleanup_first
speech_speed_multiplier = 1.2
formal_publish_has_captions_bgm_sfx
bgm_from_user_folder_only
beauty_and_relevance_material_gate
no_tiny_face_stickers
large_content_motion_overlays_on_face_moments
video_like_materials_over_static_slides
speaker_material_balance_target
full_broll_cutaway_target
full_card_not_counted_as_full_broll
multi_material_layout_when_useful
varied_sfx_not_fixed_repetition
background_blur_or_dim_when_useful
no_visible_creator_style_label
contact_sheet_and_decode_qa
```

典型失败：

```text
素材更漂亮了，但真人动态贴片没了。
全屏素材更多了，但真人/素材 50-50 失衡。
电影感更强了，但变成静态图片轮播。
贴片回来了，但变成贴脸小 pill 标签。
音乐加上了，但没有从 D:\自动剪视频BGM 选择。
素材很多，但口播重复、停顿、错话没有先清理。
```

每次成片审计至少记录：

```text
speech_cleanup_pass
speech_speed_multiplier
captions_enabled
bgm_path
sfx_event_count
beauty_relevance_gate_pass
speaker_visible_ratio
material_dominant_ratio
full_broll_count
video_like_cutaway_count
content_motion_overlay_count
multi_material_layout_count
tiny_sticker_violation_count
ppt_like_material_violation_count
decode_pass
contact_sheet_path
```

## 2026-06-14 素材强匹配、不可重复、必须动态化

用户纠正：刚才 CoramAI 试剪版仍存在素材匹配不够精确、同一素材重复出现、部分素材只是静态图片的问题。该规则只新增，不覆盖前面任何已锁定规则。

硬规则：

```text
1. 素材必须和当前句子高度匹配，不是只和大主题相关。
2. 一条成片里已经用过的素材，后面绝对不能再次出现。
3. 同一源文件、同一张生成图、同一个截图、同一段视频、同一个模板实例，在同一条视频里只能使用一次。
4. 同一概念后面再次出现时，必须重新生成/选择新的视觉主体、新场景、新角度或新视频素材。
5. 素材最终呈现必须是动态视频、动图或视频化片段；静态图片只能作为源素材，不能静态停在画面里。
6. 静态源图必须做成明显运动：推拉、平移、扫光、局部放大、数据动效、UI 动作、视差或 GIF 感。
7. 如果没有高匹配且不重复的动态素材，宁愿回到真人 + 大号内容型动态贴片，也不要硬塞低匹配、重复、静态素材。
```

QA 失败条件：

```text
素材只是泛泛 AI/财经/商业背景，不能对应当前句子。
同一个素材文件、同一张生成图或同一段视频在后面再次出现。
素材只是静态图片停住，没有视频/动图/镜头运动感。
为了凑 full_broll 数量而重复使用同一素材。
```

新增审计字段：

```text
material_match_gate_pass
low_match_material_count
unique_material_asset_count
reused_material_asset_count
static_image_only_count
dynamic_material_count
```

当前处理：`2026-06-13_CoramAI摄像头_AI安防报告_视频化50比50贴片优化版` 因存在素材重复和部分素材句子匹配不足，降级为试错版，不再作为推荐模板。

## 2026-06-14 追加更新：图片动效不能冒充真实视频素材

用户反馈：上一版 CoramAI 成片虽然做到了素材不重复、句子匹配和动态化，但很多插入素材本质仍是生成图片加推拉/扫光，观感像“图片穿插”，不像成熟财经/商业博主那种自然的视频 B-roll。该反馈成立，后续规则必须升级。

核心判断：
```text
图片做运动 = 兜底视频化素材，不等于真实视频素材。
真实视频素材 = 有真实时间流动、真实动作、镜头变化、网页/软件操作、人物/车辆/设备运动、屏幕滚动、数据动态变化、短视频片段或 GIF 感连续动作。
```

新的素材优先级：
```text
S 级：用户自有实拍视频、口播配套录屏、产品/网页/软件真实录屏、官方公开视频片段、可授权 stock video、AI 生成短视频。
A 级：真实网页滚动、GitHub/官网/公告页录屏、行情图/数据图动态绘制、鼠标移动和高亮的操作录屏。
B 级：高质量照片/生成图做明显镜头运动、景深、局部放大、视差、数据层动画，只能作为兜底。
C 级：静态图、PPT 卡、纯文字卡，不能计入真实视频 cutaway。
```

硬规则：
```text
1. 正式成片的 full_broll / real_cutaway 默认必须优先使用 S/A 级真实视频、录屏、GIF 或 AI 短视频。
2. B 级图片动效只能作为补位，不能成为整条视频主要插入形式。
3. 2 分钟左右视频里，如果规划 5-7 个全屏 cutaway，至少 60% 应为 S/A 级真实视频类素材；图片动效不得超过 40%。
4. 如果没有足够真实视频素材，必须提前标注“素材不足，当前只能做图片动效兜底版”，不能把它当成最终成熟版交付。
5. 规则审计要区分：real_video_cutaway_count、screen_recording_cutaway_count、ai_video_cutaway_count、animated_still_cutaway_count、static_card_count。
6. animated_still_cutaway_count 过高时 QA 失败或降级为试剪版，不再标记为优质成片。
7. 图片动效可用于补充抽象概念，但公司、产品、场景、案例、流程、软件、网页、交易/财经主题，应优先找真实视频或录屏。
```

后续执行方案：
```text
1. 先按文案拆分素材需求。
2. 对每个素材点先找/录 S/A 级视频素材：官网录屏、产品页滚动、行情图动态绘制、真实场景 stock video、用户提供素材。
3. 找不到再生成 AI 短视频；仍找不到才使用高质量图片动效。
4. 不允许整条片子大部分由生成图推拉构成。
5. QA 抽帧之外要抽查连续播放片段，确认插入镜头有真实运动，不只是照片移动。
```

本条规则新增，不覆盖旧规则。旧规则“素材必须美观、匹配、不重复、动态化、50/50 真人/素材、禁止小贴纸、字幕/BGM/SFX、口播先清理”全部继续保留。

## 2026-06-14 追加更新：中文优先与电影感真实素材运动

用户反馈：上一版“录屏动态素材版”虽然解决了图片推拉问题，但出现大量英文 UI/英文标签，且整体又变成动态 PPT/仪表盘堆叠，不符合目标风格。用户真正想要的是：以中文为主，素材像真实照片、电影感场景、真实视频或 AI 视频片段，运动也不能只是轻微推拉，而要有更自然的镜头运动和场景运动。

硬规则：
```text
1. 成片默认中文优先。除品牌名、股票代码、真实官网/软件原文、必要技术名词外，画面文字、标签、提示、说明、报告标题一律用中文。
2. 禁止在自制素材里大面积出现英文假 UI、英文假报表、英文假仪表盘。英文过多视为 QA 失败。
3. 禁止把“动态 UI 面板、数据仪表盘、流程卡片”当成主要视觉方向；这种形式只能少量用于确实需要解释数据/流程的句子。
4. 不要再把整条视频做成 PPT、仪表盘、软件界面轮播、卡片堆叠。即使每一帧都在动，只要观感像 PPT，也判定失败。
5. 主素材方向改为：真实照片感、电影感、纪录片感、真实场景感、AI 视频感、stock footage 感、官网/产品真实录屏感。
6. “电影感照片的动”不能只是轻微推拉。必须至少具备一种明显视频感：前后景分离、视差运动、镜头横移/推进/环绕、景深变化、光影变化、粒子/烟雾/屏幕反光、人物/车辆/设备/数据元素运动、动态遮挡或转场。
7. 静态生成图只允许作为源素材。最终出现在视频里时，必须做成强视频化片段；如果只有轻微 zoom/pan，不能算优质 cutaway。
8. 真实视频/AI 短视频/授权素材/真实录屏优先级高于自制动态图。自制动态图只能作为兜底或补充。
9. 抽帧 QA 之外，必须抽查连续播放片段，判断它是否像真实视频/电影感动图，而不是像一张图被拖动。
```

素材优先级更新：
```text
S 级：真实实拍视频、授权 stock video、AI 生成短视频、官方公开视频、用户提供的真实场景视频。
A 级：真实网页/产品/软件录屏，真实行情/图表动态录制，真实官网滚动、鼠标操作、高亮演示。
B 级：电影感真实照片/生成图 + 强 2.5D/视差/景深/光影/粒子/前后景运动，必须明显不像静态图片。
C 级：普通图片推拉、仪表盘动效、PPT 卡片、流程卡、假 UI，只能少量辅助，不得作为主素材。
```

QA 新增字段：
```text
chinese_first_pass
english_fake_ui_violation_count
ppt_dashboard_violation_count
cinematic_photo_motion_count
strong_motion_cutaway_count
weak_pan_zoom_only_count
real_or_ai_video_cutaway_count
stock_or_screen_recording_count
```

执行建议：
```text
1. 先按文案列素材需求，再为每个素材点判断是否能找到 S/A 级真实视频或录屏。
2. 找不到 S/A 级时，再生成电影感照片，并用强 2.5D/AI 视频工具做成短片段。
3. 不要为了“信息量”堆英文 UI 和仪表盘。宁愿少字、中文大字、真实场景画面更高级。
4. 对商业/财经/AI 创业口播，优先用真实公司场景、城市、办公楼、设备、门店、仓库、人物背影、交易屏、服务器、车辆、客户现场等电影感素材。
5. 若当前工具无法生成真实视频，只能导出“过渡测试版”，不能标为成熟优质成片。
```

本条规则新增，不覆盖旧规则。旧规则“口播先清理、1.2 倍语速、字幕/BGM/SFX、素材美观且匹配、不重复、50/50 真人/素材、禁止小贴纸、真实视频优先、规则审计和 QA”全部继续保留。

## 2026-06-14 新增：中文电影感强运动素材规则

- 素材层必须中文优先。除真实品牌名、股票代码、产品名外，尽量不要出现大块英文、英文假 UI、英文仪表盘或英文说明。
- 不要把全屏素材做成 PPT、卡片堆、仪表盘模板或“漂亮但像幻灯片”的画面。素材首要目标是好看，其次必须句子级匹配；两者缺一不可。
- 优先使用真实视频、真实场景、官方页面/录屏、真实照片、电影感照片、动态 GIF 或 AI 生成的电影感场景。没有真实视频时，静态图只能作为源素材，最终必须做成强视频化运动。
- “强视频化运动”最低要求：明显推近/横移/视差层次/光扫/前景阴影/焦点变化/粒子或环境运动中的多项组合；不能只是轻微 pan/zoom。
- 2 分钟左右口播可以使用约 45%-55% 真人、45%-55% 素材主导；全屏素材可以完全遮住真人，口播声音保持连续。
- 同一个素材源在一个成片里只能出现一次。若同一概念再次出现，必须换不同场景、角度、源文件或镜头语言。
- QA 审计必须记录：中文优先是否通过、英文假 UI 违规数、PPT 模板感违规数、弱 pan/zoom-only 违规数、强运动 cutaway 数、唯一素材数、复用素材数。

## 2026-06-14 追加更新：mp4 也必须通过真实视频质量门槛

本轮 CoramAI 测试确认：文件格式是 mp4/GIF 不等于合格真实视频素材。很多本地 mp4 本质仍是动态 PPT、UI 卡片、假仪表盘或模板轮播，观感仍然像“幻灯片”，不能计入优质 `real_video_cutaway`。

硬规则新增：

```text
1. real_video_cutaway 的判断不能只看文件扩展名；必须看连续播放观感。
2. 合格真实视频必须出现真实时间流动或真实场景运动，例如摄像头、保安、学校、仓库、门店、办公室、服务器、车辆、人物动作、航拍、滚动网页、真实软件操作等。
3. 动态 PPT、模板卡片、假 UI、英文仪表盘、流程卡轮播，即使导出成 mp4，也归为 C 级素材，不得计入真实视频 cutaway。
4. 如果本地没有合格真实视频，优先寻找/下载可授权 stock video、官方公开视频、真实网页/软件录屏，或调用 AI 视频工具生成短片；不能继续用卡片 mp4 硬凑。
5. stock video 可以作为试剪和正式素材，但必须做素材来源记录，且不能暗示画面人物、品牌或场景为被讲公司背书。
6. 每条成片 QA 必须同时检查“素材源抽帧总览”和“最终成片抽帧”，确认素材不是卡片化视频。
```

审计字段新增或强化：

```text
stock_video_cutaway_count
source_mp4_but_ppt_like_count
format_is_mp4_but_rejected_count
real_video_visual_gate_pass
source_contact_sheet_checked
stock_license_recorded
```

本条规则只新增门槛，不删除旧规则。旧规则“素材必须美观、句子匹配、不重复、中文优先、禁止小贴纸、50/50 真人/素材、字幕/BGM/SFX、先清理口播”继续保留。

## 2026-06-14 追加更新：强匹配混合素材与真实视频后期规则

用户反馈：上一版真实视频素材虽然解决了“图片不是真视频”的问题，但部分 stock footage 与当前句子弱相关，且真实视频上叠加进度线/扫光线会显得多余；同时之前训练过的中大号中文小卡片不能丢。

硬规则新增：

```text
1. 素材选择优先级改为：句子级匹配度第一，美观第二，最后才是形式比例。真实视频如果只是泛场景、弱相关、看起来无关，宁愿不用，改用更匹配的电影感强运动素材或重新找素材。
2. 真实视频 cutaway 必须通过“强匹配门槛”：画面主体、场景、动作或业务关系要直接对应当前口播句子。泛办公室、泛仓库、泛学校、泛门店不能自动判定合格。
3. 2 分钟左右商业/技术/财经解释视频，素材层默认采用近似 50/50 混合：约一半强匹配真实视频/录屏/stock/AI 视频，约一半电影感强运动图/动图/视频化素材。这个比例是目标，不得牺牲匹配度硬凑。
4. 如果真实视频匹配度不足，优先替换为电影感强运动素材；不要为了“真实视频占比”插入无关视频。
5. 真实视频本身已经有运动，不需要再加横向进度线、扫描线、扫光条来证明它在动。真实视频镜头只做调色、裁切、淡入淡出、轻标题/必要中文信息。
6. 中大号中文小卡片继续保留，用于强调观点、转折、风险、结论和行动建议；但必须放在安全区，不能贴脸、不能贴嘴、不能变成小贴纸。
7. 电影感强运动素材仍可使用，但必须有明显视频感：视差、光影、景深、前后景、粒子、镜头推进/横移/遮挡等；不能只是轻微 pan/zoom。
8. 同一成片内素材源继续严禁重复。即使是同一主题，也要换源、换场景、换角度或换镜头语言。
```

QA / 审计新增字段：

```text
strong_match_stock_video_count
cinematic_strong_motion_count
hybrid_stock_to_cinematic_ratio_by_count
weak_related_stock_used_count
weak_related_stock_rejected
true_video_progress_line_removed
true_video_sweep_line_removed
```

本轮 CoramAI 测试目标版本：

```text
输出：D:\自动剪视频成片\2026-06-14_CoramAI摄像头_AI安防报告_强匹配混合版_字幕BGM_1p2倍语速.mp4
干净版：D:\自动剪视频成片\2026-06-14_CoramAI摄像头_AI安防报告_强匹配混合版_干净版_1p2倍语速.mp4
审计结果：8 段强匹配真实视频 + 8 段电影感强运动；素材主导 53%，真人 47%；重复素材 0；弱相关 stock 使用 0；真实视频进度线/扫线已移除。
```

本条规则只新增，不覆盖旧规则。旧规则“口播先清理、1.2 倍语速、字幕/BGM/SFX、中文优先、素材美观且匹配、不重复、禁止贴脸小贴纸、真实视频优先、QA 抽帧与规则审计”全部继续保留。

## 2026-06-14 追加更新：正规素材站检索与授权记录规则

用户提出：为了提升素材与文案的匹配度，后续不要只依赖自生成图片/视频，也要优先去正规素材站寻找高质量视频、照片、动图、音效和可授权素材。

硬规则新增：

```text
1. 素材优先级新增“正规素材站检索”步骤：先根据文案拆成关键词，再去授权明确的素材源搜索，再按句子级匹配度、美观度、可商用风险排序。
2. 素材站素材不能盲用。每个下载素材必须记录：来源网站、素材页面 URL、作者/上传者、许可证页面 URL、下载时间、搜索关键词、匹配到的文案句子、是否需要署名、是否包含人物/商标/品牌/地标/私人场所风险。
3. 真实视频素材只在强匹配时使用。即使来自正规素材站，只要与当前文案弱相关，也不能硬插入成片。
4. 优先使用可商用、可修改、署名要求低或可控的素材；需要署名的素材必须在审计文件中标出，必要时在视频简介/素材表中留出处。
5. 含明显品牌 Logo、商标、名人脸、私人场所、敏感场景的素材，需要降级或弃用；不能暗示素材中的人物或品牌为视频观点背书。
6. 如果免费素材无法强匹配，才进入 AI 生成视频/电影感强运动图兜底；不要为了省事直接生成一堆泛图。
7. 每条成片 QA 必须包含素材来源表和授权风险字段。未记录来源的外部素材不能进入正式成片。
```

推荐素材源分层：

```text
S 级：用户自有实拍、官方公开视频/官网素材、产品实录、自己录屏。
A 级：Pexels、Pixabay、Mixkit、Coverr、Unsplash 图片、Wikimedia Commons、NASA/政府公开媒体、公司官方 press/media kit。
B 级：Videvo、Storyblocks、Envato Elements、Motion Array、Artgrid、Shutterstock、Adobe Stock 等需要逐条确认授权或付费订阅的素材库。
C 级：来源不明搬运号、别人短视频截取、带水印素材、二创混剪素材、无法确认授权的社媒素材。正式成片禁用。
```

自动检索流程：

```text
1. 文案拆分为 8-16 个素材需求点。
2. 每个需求点生成中文关键词和英文关键词，例如“AI 安防 摄像头 异常检测 / AI security camera monitoring anomaly detection”。
3. 先查官方/自有素材，再查 Pexels/Pixabay/Mixkit/Coverr/Unsplash/Wikimedia Commons。
4. 下载前做三项评分：句子匹配度、视觉美感、授权风险。
5. 只保留高匹配高美感低风险素材；弱相关素材不得因为是真视频而进入成片。
6. 下载后保存到项目资产库，并生成素材来源 JSON/CSV。
7. 渲染审计中写入每个素材的 source_url、license_url、author、attribution_required、commercial_use_risk、script_match_score、beauty_score。
```

本条规则只新增，不覆盖旧规则。旧规则“口播先清理、1.2 倍语速、字幕/BGM/SFX、中文优先、素材美观且匹配、不重复、禁止贴脸小贴纸、真实视频优先、50/50 强匹配混合素材、真实视频不加进度线/扫线、QA 抽帧与规则审计”全部继续保留。

## 2026-06-15 追加更新：先做专属视觉素材包 + 视觉相似度去重

用户反馈：老板/员工培训这条成片里，虽然审计显示素材文件没有重复，但观感上仍然像重复素材，而且部分素材匹配度不高。该问题不主要是口播不清楚，而是素材匹配链路不够硬：素材池太泛、生成模板语言重复、审计只查了文件唯一性，没有查视觉观感重复。

硬规则新增：

```text
1. “素材文件不重复”不等于“观感不重复”。同一模板、同一配色、同一卡片结构、同一镜头类型、同一泛办公室/泛仓库/泛AI画面反复出现，都算视觉相似度重复。
2. 规则审计必须区分 file_duplication 与 visual_similarity_duplication，两者都要通过。
3. 商业/财经/AI解释视频优先先做专属视觉素材包，再剪辑调用。视觉素材包必须从文案或清理后的口播逐句拆出来，不能只靠宽泛关键词随机找素材。
4. 视觉素材包必须有 shot table：shot_id、对应文案句子、素材需求、已验收素材、素材类型、来源/授权、匹配分、美感分、视觉指纹、拒绝原因。
5. 剪辑脚本只允许调用“已验收素材”或现场新审核通过的候选素材。不能因为本地有某个素材包，就硬套进去。
6. 如果某一句找不到强匹配素材，优先保留真人、生成强匹配电影感画面，或标为兜底测试版；不允许塞泛办公室、泛仓库、泛AI、泛门店素材。
7. 重要 cutaway 的默认门槛：match_score >= 0.88，beauty_score >= 0.85；低于门槛必须在审计里说明为什么仍然使用。
8. 同一条视频里，同一生成模板最多出现 2 次；如果超过，必须明显改变镜头语言、配色、布局、主体和运动方式，否则视为重复。
9. 每次正式导出必须生成“素材事件 QA 图”，按每个素材事件中点抽帧；不能只看均匀时间抽帧。素材事件 QA 是检查重复素材和弱匹配素材的主依据。
10. 如果用户提供原始文案，必须优先用文案做视觉素材包和字幕对齐；只有口播没有文案时，ASR 只能作为初稿，素材审核要更严格。
```

推荐执行链路：

```text
1. 先清理口播 / 对齐文案。
2. 把文案拆成 8-18 个视觉需求点。
3. 为每个需求点先建专属视觉素材包：真实视频、录屏、官方素材、stock、AI视频/电影感动态素材。
4. 先做素材包 QA：拒绝弱相关、丑、低清、低运动、错语义、视觉重复素材。
5. 剪辑脚本只从 accepted assets 调用，避免随机素材池和旧素材包污染时间线。
6. 最后做成片 QA：最终抽帧、素材事件 QA、视觉相似度去重、文件去重、匹配分/美感分、解码检查。
```

本条规则只新增，不覆盖旧规则。旧规则“口播先清理、1.2 倍语速、字幕/BGM/SFX、中文优先、匹配第一美感第二、不重复、禁止贴脸小贴纸、真实视频优先、拒绝军警战争冲突错素材、QA 抽帧与规则审计”全部继续保留。

## 2026-06-15 追加更新：字幕/文案必须在最终音频上重新对齐

用户反馈：成片里经常出现“讲话和文案/字幕匹配不上”，有时候字幕太快，有时候字幕太慢。该问题属于时间轴对齐失败，不主要是用户普通话问题。

硬规则新增：

```text
1. 不允许沿用原始 ASR chunk 时间作为最终字幕时间。只要做过口播清理、删停顿、删重复、拼接、1.2x 变速，就必须重新对齐字幕。
2. 字幕必须基于“最终清理后 + 最终变速后”的人声音频重新生成或强制对齐。
3. 如果用户提供原文案，原文案是文字真值；但时间仍必须通过最终音频对齐，不能按旧 ASR 块或平均时长硬铺。
4. 素材/B-roll 的开始时间也必须绑定到“对齐后的句子时间”，不能继续使用旧的固定秒点。字幕时间改了，素材时间也要跟着动。
5. 重要素材点必须在对应口播句子的 +/-0.25 秒内出现；如果是提前铺垫或回看，必须在审计里标注。
6. 中文字幕节奏标准：每行优先 8-18 个汉字，最多 2 行；目标 7-11 个汉字/秒；单条字幕最短 0.85 秒，最长 3.2 秒。
7. 太长的句子必须按自然停顿拆分字幕；太短的碎句必须合并到前后句，除非是故意强调。
8. 正常讲话段落里，字幕不能晚于声音 0.25 秒以上，也不能早于声音 0.15 秒以上。
9. 财经/商业/技术密集段默认仍可保持 1.2x 口播速度，但字幕必须拆得更细；如果局部听感真的太赶，该局部可降到 1.10-1.15x，并写进审计。
10. 每次正式导出必须生成 subtitle_alignment_report.json 或在规则审计里写入：source_text_type、alignment_method、average_drift、max_drift、fast_caption_count、slow_caption_count、cps_violation_count、sampled_caption_checks。
```

推荐执行链路：

```text
1. 先清理口播，删除重复、错话、停顿、废片段。
2. 对清理后的口播做最终速度处理，生成 final_clean_voice。
3. 对 final_clean_voice 做 word-level ASR 或 forced alignment。
4. 用用户文案/术语表修正 ASR 文本错误。
5. 从 word-level 时间或强制对齐句子生成字幕。
6. 从对齐后的句子表重新生成素材事件时间线。
7. 先做字幕同步 QA，再做最终混音和导出。
```

本条规则只新增，不覆盖旧规则。旧规则“口播先清理、1.2 倍语速、字幕/BGM/SFX、中文优先、素材美观且匹配、不重复、视觉相似度去重、专属视觉素材包优先、真实视频优先、QA 抽帧与规则审计”全部继续保留。

## 2026-06-15 追加更新：真人口播段必须保留动态资料贴片

用户反馈：最近为了避免 PPT 化，反而把之前那种“PPT 式动态资料贴片 / 动态信息卡”减少太多了。用户并不是不要这类贴片，而是不要整条视频变成 PPT 幻灯片。真人口播段里应该多加中大号动态资料贴片，这样画面更好看、更有信息节奏。

核心区别：

```text
整条视频 PPT 幻灯片化 = 不要。
真人口播段叠加中大号动态资料卡 = 要保留，并且要增加。
```

硬规则新增：

```text
1. 不允许把动态 PPT 式资料贴片完全删掉。它是当前账号风格的一部分。
2. 整体仍然保持接近 50/50：一部分是素材主导/全屏 cutaway，一部分是真人可见口播；但真人可见段不能一直干讲。
3. 真人可见口播时间里，约 60% 应该加入动态资料贴片或信息层，只留约 40% 作为干净真人呼吸段。
4. 可用贴片类型：关键数字卡、流程步骤卡、对比卡、引用卡、小流程图、清单卡、风险提醒卡、前后对比卡、时间线卡、1-3 个相关素材缩略图组合。
5. 贴片必须中大号、清晰、好看、在安全区；不能挡脸、眼睛、嘴巴和关键手势。
6. 贴片不是小贴纸。禁止贴脸小标签、小药丸、小 icon 堆叠、无意义装饰标签。
7. 贴片文字必须中文优先、短、直接对应当前句子；不能为了热闹加泛标签。
8. 贴片动画要变化：滑入、放大、堆叠出现、进度高亮、数字跳动、轻微视差、卡片切换、柔光强调等；不能每次都是同一个动作。
9. 同一条视频中，不能让一种贴片模板、配色、布局统治全片。大小、位置、数量、运动方式都要变化。
10. 全屏真实/电影感素材、真人加贴片、干净真人三种状态要自然交替，不能任何一种完全消失。
11. QA 审计必须新增或记录：face_clean_ratio、face_with_overlay_ratio、full_material_ratio、dynamic_overlay_count、overlay_face_overlap_violation_count、overlay_template_reuse_count、overlay_readability_pass。
```

推荐比例：

```text
2 分钟左右解释视频：
- 5-7 个主要全屏 / 素材主导 cutaway。
- 8-14 个真人段动态资料贴片。
- 保留少量纯真人呼吸段，但必须是有意安排，不是画面空。
```

本条规则只新增，不覆盖旧规则。旧规则“不要整条 PPT 化、真实/电影感素材优先、口播先清理、字幕对齐、素材匹配第一、美感第二、不重复、禁止贴脸小贴纸、QA 抽帧与规则审计”全部继续保留。

## 2026-06-15 追加更新：Shutterstock / Getty 搜索候选接口已接入

本条只新增，不覆盖旧规则。

```text
1. `stock_material_api.py` 已新增 `shutterstock` 和 `getty_images` provider 的搜索候选接口。
2. Shutterstock 支持环境变量：`SHUTTERSTOCK_API_TOKEN`，或 `SHUTTERSTOCK_CONSUMER_KEY` + `SHUTTERSTOCK_CONSUMER_SECRET`。已接搜索端点：`/v2/images/search`、`/v2/videos/search`。
3. Getty Images / iStock 支持环境变量：`GETTY_API_KEY`，可选 `GETTY_ACCESS_TOKEN` / `GETTY_API_SECRET`。已接搜索端点：`/v3/search/images/creative`、`/v3/search/videos/creative`。
4. 这两个 provider 当前只生成候选池，不自动下载，不自动进时间线。`download_url` 必须保持为空，直到账号订阅、授权、下载 entitlement 明确。
5. 付费站预览、水印预览、未授权 comp 图/视频不得进入正式成片。
6. 搜索候选仍必须通过旧规则：句子级强匹配、美观、无重复、中文优先、无军警战争冲突错语义、source/license manifest、人工视觉 QA。
7. 默认 provider 列表已扩展为：`nasa_images,openverse,internet_archive,wikimedia_commons,coverr,pexels,pixabay,unsplash,hellorf,shutterstock,getty_images`。缺 key 时只返回 `missing_key`，不能让整个搜索失败。
```

执行原则：

```text
优先用 Pixabay + 公共 API 立即补候选；Shutterstock / Getty 用于高质量付费候选评估，等用户开通 key 和授权后再升级为生产素材源。
```

本条规则继续保留旧规则“素材匹配第一、美感第二、比例第三；真实视频优先但弱匹配真实视频不得硬塞；所有素材必须记录来源与授权风险”。

## 2026-06-15 追加更新：16:9 素材站/API 接入状态与账号规则

用户要求：当前拍摄是 16:9 横屏，素材优先从素材网站/素材库/API 找强匹配素材；哪些能接 API 就接上，哪些需要注册登录/API key 就明确列出。

正式入口：

```text
D:\CodecX全项目管理\P08_C02_自动剪视频_auto_video_editing\50_代码_code\auto_talk_cut_mvp\scripts\stock_material_api.py
D:\CodecX全项目管理\P08_C02_自动剪视频_auto_video_editing\50_代码_code\auto_talk_cut_mvp\config\stock_provider_registry.json
D:\CodecX全项目管理\P08_C02_自动剪视频_auto_video_editing\50_代码_code\auto_talk_cut_mvp\STOCK_MATERIAL_API_SETUP.md
```

硬规则：

```text
1. 16:9 素材搜索默认使用 --orientation landscape，优先 1920x1080 / 30fps。
2. 已编码 provider：Pexels、Pixabay、Unsplash、Wikimedia Commons、HelloRF/站酷海洛、Coverr。
3. Pexels/Pixabay/Unsplash/HelloRF 缺 key 时只能返回 missing_key，不能伪造下载。
4. Wikimedia Commons 可公开检索，但每条素材必须逐条审 CC/PD/署名/相同方式共享等许可证。
5. Coverr 公共 OpenAPI 页面可见，但 2026-06-15 实测 search/list 端点返回 404/401；暂按“需站点确认 API 权限/账号”处理，不作为稳定免 key 源。
6. Shutterstock、Adobe Stock、VCG、摄图、光厂/VJ师、包图等先登记，未确认账号/订阅/API/授权前不得自动下载进素材包。
7. 单个 provider 报错不能拖垮整轮检索；应写入 provider_status.api_error，并继续查其他源。
8. API 候选只进入候选池，不能直接进时间线；进入素材包前必须通过句子级匹配、美感、授权、人物/商标/场景风险审核。
```

当前缺失凭证：

```text
PEXELS_API_KEY
PIXABAY_API_KEY
UNSPLASH_ACCESS_KEY
HELLORF_CLIENT_ID
HELLORF_CLIENT_SECRET
SHUTTERSTOCK_CONSUMER_KEY
SHUTTERSTOCK_CONSUMER_SECRET
```

本条规则只新增，不覆盖旧规则。旧规则“素材强匹配、美观、中文优先、真实视频/录屏/API/素材站候选优先、拒绝军警战争武器冲突错素材、source_manifest、QA 抽帧和规则审计”全部继续保留。

## 2026-06-15 追加更新：当前素材包目标改为 4:3

用户确认：接下来素材寻找和视觉素材包输出，先把素材全部变成 4:3，包括视频素材。素材选择顺序不变：文案内容强匹配第一，视觉美观第二，最后才是比例；如果强匹配且好看的素材是 16:9，允许先用它，再中心裁切/标准化为 4:3。

当前执行口径：

```text
1. 当前视觉素材包默认规格：4:3，1440x1080，30fps。
2. 素材检索命令：search --kind video --orientation auto --aspect 4:3。
3. 图片素材同样按 --kind photo --orientation auto --aspect 4:3。
4. 下载 accepted 候选后默认用 ffmpeg 生成 normalized_4x3 标准版；原素材仍保留并写入 source_manifest.json。
5. manifest 必须记录 original_local_path、normalized_local_path、target_aspect、target_width、target_height、aspect_score、transform_required。
6. 禁止为了找原生 4:3 而牺牲句子匹配；弱相关 4:3 不如强匹配 16:9 裁切。
7. QA 必须检查输出 PNG/JPG/MP4 为 1440x1080 / 4:3；视频为 30fps；ffprobe/ffmpeg 解码通过。
```

本条为当前 P10/P11 视觉素材包最新目标，覆盖上一条“当前本轮 16:9”的默认执行口径；只有用户明确要求 16:9 或 9:16 时才切回对应规格。

## 2026-06-15 追加更新：正式文案优先的字幕与口播对齐规则

用户反馈：上一版成片里，画面文字、字幕和实际口播有时对不上；普通话不标准、股票代码、英文产品名、同音词和 ASR 误识别会导致字幕不准。该问题成立，后续不能只依赖语音识别原文直接烧字幕。

核心规则：

```text
1. 如果用户提供正式文案，正式文案优先级高于 ASR 原始识别文本。
2. ASR 主要用于时间轴、停顿、实际发声位置、重复/错句检测；字幕文字和口播清理参考正式文案。
3. 有文案时，字幕生成流程改为：ASR 得到时间戳 -> 文案分句 -> 语义/模糊匹配对齐 -> 用文案原句生成字幕 -> 对不上处人工/规则标红审查。
4. 不允许把明显错误的 ASR 词直接烧进正式成片，例如同音错字、股票代码错识别、英文名错识别、断句错乱。
5. 文案不是硬切口播的唯一标准：如果用户实际漏读、跳读、临场改词，以“实际说了什么”为时间轴基础，但字幕尽量用文案里的正确表达修正。
6. 如果口播和文案差异过大，必须在审计里标记 `script_alignment_warning`，不能假装完全对齐。
7. 正式成片 QA 新增字幕抽查：至少抽查开头、中段、结尾各 2-3 句，确认字幕、声音、画面关键词一致。
```

默认文件放置规则：

```text
1. 用户可以把文案直接放进 `D:\自动剪视频口播`。
2. 最推荐：文案和视频同名，例如 `AI美女1.mp4` 对应 `AI美女1.txt`、`AI美女1.md`、`AI美女1.docx` 或 `AI美女1.srt`。
3. 如果无法同名，可以放最近修改的 `文案.txt`、`稿子.txt`、`script.txt`、`manuscript.txt`、`文案.md`、`稿子.md`。
4. 多段视频合并时，可使用 `视频名_1.txt`、`视频名_2.txt` 或一个总文案；总文案按视频顺序对齐。
5. 每次开始剪辑前先扫描同目录文案文件；找到文案后在规则审计里记录 `script_source_path`、`script_alignment_used=true`。
```

执行方案：

```text
1. 先读取同名或最新文案，做清洗：去多余空行、统一标点、保留股票代码/品牌名/数字。
2. ASR 转写后先做术语纠错，再和文案分句做相似度对齐。
3. 重复口播判断优先参考文案顺序：同一句或近似同一句出现多遍时，保留最完整、最顺的一遍。
4. 字幕使用文案里的规范句子，但时间使用实际口播片段时间。
5. 如果文案有而口播没说，不强行加字幕；如果口播说了文案没有的新内容，保留为口播增补句并在审计中记录。
6. 口播清理、素材匹配、B-roll 时间点都以“文案对齐后的干净口播时间线”为准。
```

本条规则只新增，不覆盖旧规则。旧规则“口播先清理、1.2 倍语速、字幕/BGM/SFX、中文优先、素材美观且匹配、不重复、禁止贴脸小贴纸、真实视频优先、4:3 大横板/无顶部弹幕、QA 抽帧与规则审计”全部继续保留。

## 2026-06-15 事故修正：多段口播合并前必须做源文件内容核验

事故：用户要求把 `AI美女1` 和 `AI美女2` 两段口播按顺序衔接剪辑。实际执行时只按文件名选择了 `ＡＩ美女１.mp4` 和 `ＡＩ美女２.mp4`，没有先做内容核验，导致 `ＡＩ美女１.mp4` 开头内容实际是“老板天天教员工 / Synthesia / AI培训视频”，和用户预期的“AI美女1”主题不一致。用户反馈“把另外一个视频和 AI美女2 混在一起”，该反馈成立。

新增硬规则：

```text
1. 多段视频合并（1/2、上/下、part1/part2、连续两条口播）之前，必须做 source preflight。
2. 文件名不能作为唯一依据。必须核验：完整路径、文件大小、SHA256、时长、第一帧/中段/末帧抽帧、开头/结尾 3-5 句转写摘要。
3. 生成 `source_sequence_manifest.json`，记录每一段的 filename、hash、duration、visual_contact_sheet、opening_transcript、ending_transcript、topic_guess、sequence_index。
4. 如果某一段的开头主题、人物、场景或文案明显不像用户指定的项目，必须停止并提示“源文件疑似放错/命名错”，不能继续渲染。
5. 合并后必须再抽查 merged_source：前半段是否来自 part1，后半段是否来自 part2；不能只检查 concat 命令成功。
6. 成片交付前审计必须包含 `source_sequence_verified=true` 和 `source_sequence_manifest_path`。没有通过源序列核验的多段合并成片不得交付为正式版。
7. 如果用户后来指出混入了别的视频，优先回查源文件内容和转写，不要先辩解“文件名没错”。
```

执行模板：

```text
1. 扫描输入目录候选视频。
2. 对候选 part1/part2 生成抽帧图和开头/结尾转写摘要。
3. 判断是否同一主题、同一项目、同一口播序列。
4. 通过后再 concat 合并；不通过则暂停，等待用户替换正确源文件或提供正式文案。
5. 规则审计记录 source preflight 结果。
```

本条规则只新增，不覆盖旧规则。旧规则“口播先清理、文案优先字幕、1.2 倍语速、字幕/BGM/SFX、中文优先、素材美观且匹配、不重复、真实视频优先、4:3 大横板/无顶部弹幕、QA 抽帧与规则审计”全部继续保留。

## 2026-06-15 追加更新：16:9 横屏素材包与素材站/API优先规则

用户确认：当前要拍的视频是 `16:9` 横屏。因此当任务明确为本轮横屏视频或用户指定 `16:9` 时，素材包和成片素材必须按横屏逻辑执行，不再沿用竖屏默认尺寸。

硬规则新增：

```text
1. 当前 16:9 项目的图片、视频、截图、录屏、素材站下载素材，默认目标为横屏 16:9，优先 1920x1080，稳定 30fps MP4。
2. 9:16 / 1080x1920 是旧竖屏默认，只在用户明确说竖屏、短视频竖版、抖音/视频号竖屏时使用；本轮横屏视频不能误用旧竖屏脚本。
3. 素材站/API检索必须优先使用横屏候选：Pexels/Pixabay API 搜索传 `--orientation landscape`；网页手动检索时也优先筛选横屏/16:9 视频或可安全裁成 16:9 的高分辨率素材。
4. 素材来源优先级不变：官方/自有素材 > 已授权素材站/API候选 > 真实录屏/网页滚动 > AI视频/电影感强运动素材兜底 > 普通图片动效。
5. API 只生成候选池，不直接进时间线。每个候选仍必须过句子级匹配、美感、授权、人物身份/场景风险审核。
6. 如果 API key 缺失或素材站未返回强匹配横屏素材，必须标注“素材站/API候选不足”，再用公开网页手动下载、官方素材、录屏或 AI 视频兜底；不能编造已经下载的素材。
7. 横屏素材包 QA 必须检查：1920x1080/16:9、30fps、完整解码、source_manifest/source URL、授权风险、素材强匹配、非重复、无军警/战争/冲突错素材、无 PPT/假 UI 冒充真实视频。
```

默认命令更新：

```powershell
python C:\Users\进步\Documents\自动前视频\scripts\stock_material_api.py search `
  --query "AI startup office founders laptop meeting" `
  --sentence "当前口播句子" `
  --kind video `
  --orientation landscape `
  --per-provider 10
```

当前本机状态：`stock_material_api.py` 已支持 `--orientation landscape|portrait|any`，但 2026-06-15 doctor 检查显示 `PEXELS_API_KEY` 和 `PIXABAY_API_KEY` 暂未配置。未配置前只能生成 missing_key 状态和空候选池，正式自动下载需先把 key 放进本机环境变量或 `.env.local`。

## 2026-06-14 追加：素材站 API 接入执行规则

第一批 API provider：

```text
Pexels：环境变量 PEXELS_API_KEY；自动化接口用于 video/photo 搜索。
Pixabay：环境变量 PIXABAY_API_KEY；自动化接口用于 video/photo 搜索。
```

本机落地：

```text
C:\Users\进步\Documents\自动前视频\scripts\stock_material_api.py
C:\Users\进步\Documents\自动前视频\config\stock_provider_registry.json
C:\Users\进步\Documents\自动前视频\.env.example
C:\Users\进步\Documents\自动前视频\STOCK_MATERIAL_API_SETUP.md
```

硬规则：

```text
1. API 搜索只生成候选池，不能自动直接进最终时间线。
2. 候选素材排序仍按：句子匹配度第一，美观第二，授权/商用风险第三，provider 优先级第四，比例最后。
3. 下载素材必须生成 source_manifest.json，记录 provider、source_url、creator、license_url、query、matched_script_sentence、match_score、beauty_score、commercial_risk、manual_review_flags。
4. Pexels/Pixabay API 返回素材仍必须视觉 QA；不能因为是正版素材就跳过匹配度和身份场景审查。
5. 商业/财经/AI/摄像头/门店/仓库/学校/老板报告类文案默认拒绝 soldier、military、army、police、weapon、gun、war、combat、battlefield、riot、prison、jail、crime scene、violence 等强语义错素材。
6. 其他 provider 先保留不启用：Unsplash、Wikimedia Commons、Mixkit、Coverr、Videvo、Storyblocks、Envato Elements、Motion Array、Artgrid、Shutterstock、Adobe Stock。启用前必须确认 API、账号、授权和署名规则。
7. API key 只放本机环境变量或 .env.local，不进入 GitHub、不进入公开说明、不进入成片审计。
```

默认命令：

```powershell
python scripts\stock_material_api.py doctor
python scripts\stock_material_api.py search --query "security camera monitoring office warehouse" --sentence "当前口播句子" --kind video --per-provider 10
python scripts\stock_material_api.py download --candidates stock_api_cache\xxx_candidates.json --limit 3 --out-dir downloaded_stock_video_api
```

本条规则只新增，不覆盖旧规则。

## 2026-06-15 追加更新：最终成片与素材包统一 4:3

用户确认：当前不仅素材包要改为 4:3，最终成片也要做 4:3。竖屏素材也可以优先找，只要内容匹配和画面好，再转成 4:3。

硬规则新增：

```text
1. 当前默认最终成片：4:3，1440x1080，30fps MP4。
2. 当前默认视觉素材包：4:3，1440x1080，MP4 30fps。
3. 4:3 项目的素材检索不限定源素材横竖。`--orientation auto --aspect 4:3` 等于 source orientation any。
4. 候选排序永远是：句子级内容匹配第一，美观第二，比例/转制便利第三。
5. 不得为了原生 4:3 选择弱相关素材。强匹配、好看的 16:9 或竖屏素材优先，之后标准化成 4:3。
6. 16:9/宽素材可中心裁切到 4:3；竖屏/窄素材优先使用模糊背景 + 居中主体保内容转 4:3，不做破坏性硬裁。
7. QA 必须检查素材包和最终成片均为 1440x1080 / 4:3，MP4 为 30fps，ffmpeg/ffprobe 解码通过。
```

脚本状态：

```text
D 盘 stock_material_api.py：默认 4:3；auto 源方向为 any；下载后自动生成 normalized_4x3；竖屏素材用保内容方式转 4:3。
D 盘 smart_talk_editor.py：默认最终输出 4:3 / 1440x1080 / 30fps，报告记录 source_profile 和 target_format。
P10 normalize_visual_package_to_4x3.py：支持竖屏/窄素材保内容 4:3 标准化。
```

## 2026-06-14 追加更新：素材站账号/API 与人物身份强审核规则

用户反馈：上一版成片出现外国军人/军装人物片段，完全不符合 CoramAI 摄像头、AI 安防、线下老板报告这类商业文案。该问题属于素材匹配失败，必须写入硬规则。

硬规则新增：

```text
1. 商业、财经、AI 创业、摄像头、门店、仓库、学校、老板报告类文案，默认禁止使用军人、战争、战术、警察执法、暴力冲突、海外军装、武器、审讯、监狱等强语义素材，除非文案明确讲这些场景。
2. “安防/security”不能自动等同于 military/soldier/police/war。优先搜索 commercial security、CCTV camera、security camera, office security, warehouse monitoring, retail surveillance, access control, security guard in office/campus/warehouse 等商业安防关键词。
3. 每个素材站结果必须做人物身份与场景审核：人物是谁、在哪里、在做什么、是否会让观众误解成军警/战争/犯罪/政治/冲突。如果答案不贴当前句子，直接拒绝。
4. 素材站素材必须先经过“候选池”而不是直接进时间线。每个需求点至少保留 3-10 个候选，按脚本强匹配、美感、授权风险排序，最后只选第一梯队。
5. 不允许因为素材是真视频、清晰、好看，就绕过文案匹配。错素材比没有素材更糟。
```

素材站账号/API 规则：

```text
Pexels：网页手动下载通常不需要登录；自动化 API 需要 Pexels 账号申请 API key，环境变量建议 PEXELS_API_KEY。
Pixabay：网页手动下载可作为临时方式；自动化 API 需要登录后获取 API key，环境变量建议 PIXABAY_API_KEY。
Unsplash：主要用于图片；自动化 API 需要开发者账号、注册应用和 access key，环境变量建议 UNSPLASH_ACCESS_KEY。
Mixkit：适合手动检索视频/音乐/音效；不同素材类型有不同 license，必须逐条确认，不默认走 API。
Coverr：可用于视频，但免费素材署名/品牌/人物/商标风险要逐条记录；API/Plus/免费下载规则要逐条确认。
Wikimedia Commons：读 API 通常不靠商业 API key，但必须设置规范 User-Agent，并逐条检查 CC/PD/署名/相同方式共享等许可证。
付费站：Storyblocks、Envato Elements、Motion Array、Artgrid、Shutterstock、Adobe Stock 等需要用户账号/订阅/授权记录，不能默认免费使用。
```

自动化执行规则：

```text
1. 如果用户没有提供素材站账号/API key，先用可公开访问的网页检索和少量手动下载方式做试剪；正式规模化自动检索建议用户注册 Pexels、Pixabay 两个基础账号并提供 API key。
2. API key 不写进视频项目公开文件，不提交 GitHub；只放本机环境变量或私有配置。
3. 下载素材后必须生成 source_manifest.json，记录 source_site、source_url、license_url、creator、downloaded_at、query、matched_script_sentence、identity_scene_check、commercial_risk、attribution_required。
4. 对每个素材生成缩略图/短预览，先过视觉审核，再允许进入渲染脚本。
5. 军人/战争/警察执法/冲突等敏感强语义素材默认加入 reject_tags，除非文案明确要求。
```

本条规则只新增，不覆盖旧规则。旧规则“口播先清理、1.2 倍语速、字幕/BGM/SFX、中文优先、素材美观且匹配、不重复、禁止贴脸小贴纸、真实视频优先、50/50 强匹配混合素材、真实视频不加进度线/扫线、QA 抽帧与规则审计”全部继续保留。

## 2026-06-15 更新：素材站 API 池扩展与注册接入策略

本条只新增，不覆盖旧规则。

```text
1. 素材站不再只盯 Pexels/Pixabay/Unsplash。正式 provider pool 至少包含：
   Pexels、Pixabay、Unsplash、Wikimedia Commons、Coverr、NASA Images、HelloRF、VCG、摄图网、包图网、VJ师、千图、Shutterstock、Getty Images/iStock、Pond5、Adobe Stock、Storyblocks、Mixkit、Envato Elements、Motion Array、Artgrid。
2. 第一优先级：Pexels、Pixabay。目标是快速补齐真实视频 cutaway。
3. 第二优先级：Unsplash。目标是补高质量照片，并做强视频化/电影感动态，不把普通图片推拉当成熟视频。
4. 第三优先级：HelloRF、VCG、摄图网、包图网、VJ师、千图。目标是中文商业/财经/AI/职场语境更匹配，但必须确认 API、账号、订阅和商用授权。
5. 第四优先级：Shutterstock、Getty Images/iStock、Pond5、Adobe Stock、Storyblocks 等付费/企业站。只在账号、订阅、授权和下载条款明确后进入正式成片。
6. Wikimedia Commons、NASA Images 是公开 API，但每条素材仍要逐条检查许可证/来源/署名/是否适合商业视频语境。
7. 所有 key 只写入 auto_talk_cut_mvp\.env.local 或 Windows 私有环境变量，不写进公开文档和 GitHub。
8. doctor 只检查 key 是否存在，不输出密钥内容。
9. API 接通不等于素材可用。所有素材必须继续通过：句子级匹配、美观、无水印、无重复、source_manifest、许可风险、人物身份/场景语义审核、QA 抽帧。
10. 如果 provider 没有真实 key 或授权未确认，只能标记为 pending/manual/reserved，不允许假装已接入或直接进入时间线。
```

## 2026-06-15｜无 key 公共素材 API 已接入

- 用户明确反馈：Pexels/Pixabay 注册和风控太麻烦，不能把工作流卡在一个站点上。
- 已真实接入并测试通过：NASA Images、Openverse、Internet Archive、Wikimedia Commons。它们不需要用户注册 key 即可返回 JSON 候选。
- 当前默认搜索顺序已改为先搜公开 API：`nasa_images,openverse,internet_archive,wikimedia_commons,coverr,pexels,pixabay,unsplash,hellorf`。
- 测试结果：photo 搜索中 Openverse/Internet Archive 返回候选；video 搜索中 NASA/Wikimedia/Internet Archive 返回候选；Archive 命中 military 时会被 hard_reject 自动拒绝。
- 重要规则：公开 API 有候选不等于可直接成片。NASA 需查 NASA media guidelines/背书/人物/商标，Openverse 需查 CC license，Internet Archive 权利差异很大，必须 source_manifest + QA 后才能进正式时间线。
## 2026-06-15 追加更新：素材 API 试接优先级与防烂素材规则

用户反馈：Pexels / Pixabay 注册与登录链路容易触发反机器人或客户端空白页，同时之前自动下载的部分素材出现低质、弱匹配、错语义问题。后续素材 API 接入必须按“能稳定接入 + 素材质量高 + 文案强匹配”的顺序推进，不再为了接 API 而接 API。

硬规则新增：

```text
1. Pexels / Pixabay 如果继续触发反机器人、白屏、客户端异常，不再死磕；保留已接代码，等账号稳定后再填 key。
2. 如果 Pixabay 显示账号停用、要求重新激活、登录异常，直接暂停 Pixabay；不要继续反复尝试导致账号风险升高。
3. 免费站卡住时，先使用已接入的 no-key 公共 API：NASA Images、Openverse、Internet Archive、Wikimedia Commons，但这些只生成候选池，不能绕过授权与视觉 QA。
4. 下一轮需要用户配合申请 key 的优先级：Shutterstock、HelloRF/站酷海洛、VCG/视觉中国、Getty/iStock、Unsplash、Envato。
5. Shutterstock 优先用于海外高质量图片/视频/音乐候选；HelloRF 和 VCG 优先用于中文商业、财经、职场、城市、产业、教育、本地场景素材。
6. Adobe Stock 暂不作为第一优先级，因为官方文档显示其 Stock API 主要面向 Enterprise / approved program。
7. 包图、光厂、摄图、千图等国内站点，在未确认公开 API 或商务 API 前，只作为手动/订阅/商务候选源，不默认自动下载。
8. GIPHY / Tenor 类 GIF API 不作为财经商业解释视频的主素材源，除非文案明确需要表情化或娱乐化动图。
9. API 结果质量必须严审：素材先过句子级匹配，再过美观度，再过版权风险。低质、恶心、无关、军警战争冲突、泛场景素材一律拒绝。
10. 任何 provider 的候选都不能直接进时间线；必须先写入 source_manifest，再做素材预览、匹配评分、美感评分、授权风险记录。
11. 若当前 API 只能找到弱相关素材，宁愿生成强匹配电影感/AI 视频素材，或标记为测试版，也不能硬塞错素材。
```

试接网址与环境变量：

```text
Shutterstock: https://www.shutterstock.com/account/developers/apps
ENV: SHUTTERSTOCK_CONSUMER_KEY / SHUTTERSTOCK_CONSUMER_SECRET

HelloRF / 站酷海洛: https://open.hellorf.com/
ENV: HELLORF_CLIENT_ID / HELLORF_CLIENT_SECRET

VCG / 视觉中国: https://www.vcgapi.com/
ENV: VCG_API_KEY / VCG_API_SECRET

Getty Images / iStock: https://developers.gettyimages.com/
ENV: GETTY_API_KEY / GETTY_API_SECRET

Unsplash: https://unsplash.com/developers
ENV: UNSPLASH_ACCESS_KEY

Envato Market: https://build.envato.com/api/
ENV: ENVATO_PERSONAL_TOKEN
```

本条规则只新增，不覆盖旧规则。旧规则“口播先清理、1.2 倍语速、字幕/BGM/SFX、中文优先、素材美观且匹配、不重复、禁止贴脸小贴纸、真实视频优先、50/50 强匹配混合素材、真实视频不加进度线/扫线、QA 抽帧与规则审计”全部继续保留。
