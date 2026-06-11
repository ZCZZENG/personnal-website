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
- **卡片**：bg2 底 + border2 描边 + 12px 圆角，hover 时描边转金。禁止彩色侧条边框。
- **来源索引（vtl-src/ft-src）**：10px faint 色，事件卡片底部。

## Motion

过渡 0.2–0.5s，缓动用 ease 或 cubic-bezier(.16,1,.3,1)（ease-out-expo 系）；不弹跳。页面切换：opacity + translateY(20px)。只动 transform/opacity，不动布局属性。尊重 prefers-reduced-motion。

## Layout

单文件 SPA，6 个 tab 页绝对定位互切，.page 自身是滚动容器（sticky/IntersectionObserver 的 root 都要挂在 .page 上，不是 window）。内容列宽 880–1100px。
