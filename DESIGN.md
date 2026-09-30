# Design

从 index.html 现行实现提炼。改动任何页面前先对齐这里的 token。

## Theme

暗色金调（dark gold）。物理场景：访问者在任意环境下安静阅读一份个人编年史，金色 = 「淘金」自我叙事的延续。不是工具暗色，是叙事暗色。

## Colors

```css
--bg:        #0b0a07;   /* 页面底 */
--bg2:       #131108;   /* 卡片底 */
--bg3:       #1a1810;   /* 卡片 hover/强调底 */
--bg4:       #221f12;
--border:    rgba(164,129,17,0.18);  /* 金色描边 */
--border2:   rgba(255,255,255,0.06); /* 中性描边 */
--text:      #f0ede4;
--muted:     #8a8270;
--faint:     #4a4438;
--gold:      #A48111;   /* 品牌主色 */
--gold-lt:   #C9A527;   /* 金色高亮 */
--gold-dim:  rgba(164,129,17,0.12);
--gold-glow: rgba(164,129,17,0.28);
--green:     #6ab47b;   /* 辅色：成果/求职 */
--purple:    #a78bfa;   /* 辅色：情绪/认知 */
```

足迹页轨道色约定：项目 = gold-lt，求职 = green，情绪 = purple，生活 = #9a917c（中性偏亮）。

## Typography

系统栈：`-apple-system,'PingFang SC','Helvetica Neue',sans-serif`，不引外部字体。
层级靠 scale + weight：h1 clamp(44~72px)/800，h2 clamp(30~44px)/700，章节 h3 22~24px/700，卡片 h4 15px/600，正文 13~14px，来源/标签 10~11px + letter-spacing .1em + uppercase（eyebrow 模式）。正文 line-height 1.7–1.9。

## Components

- **eyebrow**：11px/700/.16em/uppercase/gold，页面顶部小标。
- **chip**：圆角 100px 胶囊，bg3 底 + border2 描边；gold/green/purple 变体。
- **卡片**：bg2 底 + border2 描边 + 14–18px 圆角，hover 时描边转金并亮起指针柔光。禁止彩色侧条边框。
- **页面开场 `.pg-hd`**：eyebrow + clamp(40~68px)/800 标题 + 一句 lede（muted，≤600px 宽）。
- **分节标题 `.sec-hd`**：eyebrow + 渐隐细线，分节间距 112px（移动端 72px）。
- **统计面板**：1px 金线分隔的网格，大号 gold-lt 数字 + muted 说明（hero、代表作品、周反馈共用这一语言）。
- **来源索引（vtl-src/ft-src）**：10px faint 色，事件卡片底部。

## Motion

统一 token：`--ease: cubic-bezier(.16,1,.3,1)`（ease-out-expo，默认）、`--ease-io: cubic-bezier(.65,0,.35,1)`（只用于时间线轴线绘制）。不弹跳，只动 transform / opacity（导航胶囊的 width 是唯一例外）。所有效果在 `prefers-reduced-motion` 下关闭或直接落到终态。

- **页面切换**：旧页 0.2s 淡出上移 10px；新页 opacity .55s + translateY(28px→0) .8s。`go()` 在新页激活后给它加 `.entered` 并派发 `pageenter` 事件，各模块据此开场。
- **页面开场**：`.pg-hd`（eyebrow + 大标题 + lede）子元素依次 fxIn，间隔约 .08s；每次进入页面都重放。
- **滚动揭示**：`.rv` → `.rv.in`（translateY 32px + 淡入），同一批按 DOM 顺序错峰 90ms，最多 5 级。页面首次进入时才布设，揭示完移除 `.rv` 让卡片自身 hover 过渡接管。IntersectionObserver 的 root 是 `.page`。
- **分节标题 `.sec-hd`**：小标 + 一条自左向右画出的细线。
- **光感卡片**：一个委托的 pointermove（rAF 节流）只给当前悬停卡片写 `--mx/--my`，背景是跟随指针的柔金光；可交互卡片悬停上抬 4px。仅 `hover:hover` 设备。
- **导航**：滑动胶囊指示当前页；底部 1px 金色发丝线是当前页阅读进度（经历页桌面端跟随横向时间线）。
- **数字**：`[data-count]` 在揭示时从 0 滚动到原值，结束还原原文。
- **时间线**：首次进入时轴线从左到右画出（1.9s），刻度 / 节点 / 章节 / 事件列按横向位置依次出现；金色播放头随横向滚动扫过，经过的月份节点点亮、当前章节标题提亮。移动端竖版：进度轴随阅读生长，经过屏幕中线的节点点亮，卡片逐条揭示；非里程碑卡片默认收起为两行摘要，点击展开全文与出处。

## Layout

单文件 SPA，6 个 tab 页绝对定位互切，.page 自身是滚动容器（sticky/IntersectionObserver 的 root 都要挂在 .page 上，不是 window）。内容列宽 880–1100px。
