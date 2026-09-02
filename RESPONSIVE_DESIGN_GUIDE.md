# Responsive Web Design Guide
## African Journal of Library and Information Science Theme

---

## Table of Contents
1. [Overview](#overview)
2. [Core Foundations](#core-foundations)
3. [Responsive Typography](#responsive-typography)
4. [Layout Systems](#layout-systems)
5. [Media Queries](#media-queries)
6. [Best Practices](#best-practices)
7. [Implementation Examples](#implementation-examples)
8. [Troubleshooting](#troubleshooting)

---

## Overview

This theme implements comprehensive responsive web design using modern CSS techniques following a **mobile-first workflow**. All components automatically scale and adapt across:

- **Smartwatches** (280px - 320px)
- **Mobile devices** (320px - 767px)
- **Tablets** (768px - 991px)
- **Laptops** (992px - 1199px)
- **Desktops** (1200px - 1399px)
- **Ultra-wide displays** (1400px+)

### Key Technologies

- **CSS Grid** with `auto-fit` and `minmax()` for flexible layouts
- **CSS Flexbox** for component alignment and wrapping
- **Fluid Typography** using CSS `clamp()` function
- **Responsive Images** using `max-width: 100%` and `<picture>` elements
- **Mobile-first approach** with progressive enhancement via media queries
- **Touch-friendly** minimum touch targets (44px × 44px)

---

## Core Foundations

### 1. Global Box Sizing

All elements use `box-sizing: border-box`:

```css
html {
    box-sizing: border-box;
}

*,
*:before,
*:after {
    box-sizing: inherit;
}
```

**Why?** This ensures padding and borders are included in width/height calculations, making responsive layouts more predictable.

### 2. Viewport Meta Tag

Already configured in `templates/frontend/components/headerHead.tpl`:

```html
<meta name="viewport" content="width=device-width, initial-scale=1">
```

**Why?** This tells mobile browsers to use device width for layout and sets initial zoom to 100%.

### 3. Responsive Images

All images automatically scale to fit their containers:

```css
img {
    max-width: 100%;
    height: auto;
    display: block;
}
```

**Why?** Images never overflow their containers and maintain aspect ratios.

---

## Responsive Typography

### Fluid Type Scaling

Use CSS `clamp()` for smooth typography scaling between breakpoints:

```css
h1 {
    font-size: clamp(1.75rem, 5vw, 3.5rem);
    /* min: 1.75rem, preferred: 5% of viewport width, max: 3.5rem */
}
```

**Formula**: `clamp(min, preferred, max)`

- **min**: Minimum font size (prevents being too small)
- **preferred**: Responsive value using `vw` (viewport width %)
- **max**: Maximum font size (prevents being too large)

### Typography Scale Reference

```
h1: clamp(1.75rem, 5vw, 3.5rem)      // 28px - 56px
h2: clamp(1.5rem, 4vw, 2.8rem)       // 24px - 45px
h3: clamp(1.25rem, 3vw, 2.2rem)      // 20px - 35px
h4: clamp(1.1rem, 2.5vw, 1.75rem)    // 18px - 28px
h5: clamp(1rem, 2vw, 1.5rem)         // 16px - 24px
h6: clamp(0.9rem, 1.8vw, 1.25rem)    // 14px - 20px

body: clamp(0.9rem, 1.2vw, 1.1rem)   // 14px - 18px
small: clamp(0.75rem, 0.9vw, 0.95rem) // 12px - 15px
```

### Line Height Scaling

```css
body {
    line-height: clamp(1.5, 1.5 + 0.3vw, 1.75);
    /* Scales from 1.5 to 1.75 for better readability */
}
```

---

## Layout Systems

### 1. Auto-Fit Grid Layout

Automatically adjusts columns without media queries:

```css
.grid-auto {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: clamp(0.75rem, 2vw, 1.5rem);
}
```

**Behavior:**
- Mobile (320px): 1 column
- Tablets (768px): 2-3 columns
- Desktops (1200px): 3-4 columns

### 2. Flexible 2-Column Grid

```css
.grid-2 {
    display: grid;
    grid-template-columns: 1fr;      /* Mobile: 1 column */
    gap: clamp(0.75rem, 2vw, 1.5rem);
}

@media (min-width: 768px) {
    .grid-2 {
        grid-template-columns: 1fr 1fr; /* Tablet+: 2 columns */
    }
}
```

### 3. Flexible 3-Column Grid

```css
.grid-3 {
    display: grid;
    grid-template-columns: 1fr;      /* Mobile: 1 column */
    gap: clamp(0.75rem, 2vw, 1.5rem);
}

@media (min-width: 768px) {
    .grid-3 {
        grid-template-columns: 1fr 1fr; /* Tablet: 2 columns */
    }
}

@media (min-width: 992px) {
    .grid-3 {
        grid-template-columns: 1fr 1fr 1fr; /* Desktop: 3 columns */
    }
}
```

### 4. Fluid Container with Max-Width

```css
.container {
    width: 100%;
    max-width: 100%;           /* Mobile */
    padding: clamp(0.75rem, 2vw, 2rem);
    margin: 0 auto;
}

@media (min-width: 768px) {
    .container {
        max-width: 750px;      /* Tablets */
    }
}

@media (min-width: 992px) {
    .container {
        max-width: 970px;      /* Laptops */
    }
}

@media (min-width: 1200px) {
    .container {
        max-width: 1170px;     /* Desktops */
    }
}
```

---

## Media Queries

### Breakpoint Reference

```
xs (Extra Small): 0px - 575px        (Mobile phones)
sm (Small):       576px - 767px      (Large phones)
md (Medium):      768px - 991px      (Tablets)
lg (Large):       992px - 1199px     (Small laptops)
xl (Extra Large): 1200px - 1399px    (Desktops)
2xl (2X Large):   1400px+            (Large monitors)
```

### Mobile-First Approach

**Step 1:** Write mobile styles first (default)

```css
.article-grid {
    display: grid;
    grid-template-columns: 1fr;  /* Mobile: 1 column */
    gap: 1rem;
}
```

**Step 2:** Enhance for larger screens using `min-width`

```css
@media (min-width: 768px) {
    .article-grid {
        grid-template-columns: 1fr 1fr;  /* Tablets: 2 columns */
    }
}

@media (min-width: 992px) {
    .article-grid {
        grid-template-columns: 1fr 1fr 1fr;  /* Desktops: 3 columns */
    }
}
```

### Feature-Based Media Queries

```css
/* Touch devices (no hover capability) */
@media (hover: none) and (pointer: coarse) {
    button {
        min-height: 48px;  /* Larger touch targets */
    }
}

/* Dark mode support */
@media (prefers-color-scheme: dark) {
    body {
        background: #1a1a1a;
        color: #ffffff;
    }
}

/* Reduced motion (accessibility) */
@media (prefers-reduced-motion: reduce) {
    * {
        animation-duration: 0.01ms !important;
        transition-duration: 0.01ms !important;
    }
}

/* High contrast mode (accessibility) */
@media (prefers-contrast: more) {
    a {
        text-decoration: underline;
    }
}
```

---

## Best Practices

### 1. Mobile-First Workflow

❌ **Don't:** Start with desktop, then shrink

```css
/* AVOID */
.content {
    grid-template-columns: 1fr 1fr 1fr;  /* Desktop first */
}

@media (max-width: 991px) {
    .content {
        grid-template-columns: 1fr;  /* Then reduce */
    }
}
```

✅ **Do:** Start with mobile, then enhance

```css
/* GOOD */
.content {
    grid-template-columns: 1fr;  /* Mobile first */
}

@media (min-width: 768px) {
    .content {
        grid-template-columns: 1fr 1fr;
    }
}

@media (min-width: 992px) {
    .content {
        grid-template-columns: 1fr 1fr 1fr;
    }
}
```

### 2. Use Fluid Units, Not Fixed Pixels

❌ **Avoid fixed pixels:**

```css
.container {
    padding: 20px;  /* Fixed */
}
```

✅ **Use fluid units:**

```css
.container {
    padding: clamp(0.75rem, 2vw, 2rem);  /* Responsive */
}
```

### 3. Responsive Images

❌ **Avoid:**

```html
<img src="large-image.jpg" width="800" height="600" alt="">
```

✅ **Do:**

```html
<picture>
    <source media="(min-width: 1024px)" srcset="large.jpg">
    <source media="(min-width: 768px)" srcset="medium.jpg">
    <img src="small.jpg" alt="Responsive image" style="max-width: 100%; height: auto;">
</picture>
```

### 4. Touch-Friendly Touch Targets

Minimum 44px × 44px for mobile touch targets:

```css
button,
a.link-button,
.interactive-element {
    min-height: clamp(44px, 10vw, 56px);
    min-width: clamp(44px, 10vw, 56px);
}
```

### 5. Test Across Real Devices

- Use browser DevTools device emulation
- Test on actual phones, tablets, and monitors
- Use Chrome DevTools breakpoint preview
- Use Firefox Responsive Design Mode

---

## Implementation Examples

### Example 1: Responsive Article Grid

```less
.article-grid {
    display: grid;
    grid-template-columns: 1fr;  // Mobile: 1 column
    gap: clamp(1rem, 3vw, 2rem);
    padding: clamp(1rem, 2vw, 2rem);
}

@media (min-width: 576px) {
    .article-grid {
        grid-template-columns: 1fr 1fr;  // 2 columns on tablets
    }
}

@media (min-width: 992px) {
    .article-grid {
        grid-template-columns: 1fr 1fr 1fr;  // 3 columns on desktop
    }
}

@media (min-width: 1400px) {
    .article-grid {
        grid-template-columns: 1fr 1fr 1fr 1fr;  // 4 columns on ultra-wide
    }
}
```

### Example 2: Responsive Navigation

```less
.navbar {
    display: flex;
    flex-direction: column;  // Mobile: vertical
    gap: clamp(0.5rem, 1vw, 1rem);
}

.navbar-nav {
    display: flex;
    flex-direction: column;
    gap: 0;
}

@media (min-width: 768px) {
    .navbar {
        flex-direction: row;  // Tablet+: horizontal
    }

    .navbar-nav {
        flex-direction: row;
    }
}

.nav-link {
    padding: clamp(0.5rem, 1.5vw, 1.25rem);
    font-size: clamp(0.85rem, 1.2vw, 1.1rem);
}
```

### Example 3: Responsive Statistics Cards

```less
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(clamp(180px, 25vw, 250px), 1fr));
    gap: clamp(1rem, 3vw, 2rem);
}

.stat-card {
    padding: clamp(1rem, 3vw, 1.5rem);
    min-height: clamp(180px, 30vw, 280px);
    border: 2px solid @faded-grey;
    transition: all 300ms ease;

    &:hover {
        transform: translateY(-2px);
        border-color: @primary;
    }
}

@media (max-width: 767px) {
    .stat-card {
        min-height: auto;  // No minimum on mobile
    }
}
```

---

## Troubleshooting

### Issue: Content overflows on mobile

**Cause:** Fixed-width elements not responsive

**Solution:**
```css
/* ❌ WRONG */
.content { width: 800px; }

/* ✅ CORRECT */
.content { 
    width: 100%;
    max-width: 800px;
    padding: clamp(0.75rem, 2vw, 2rem);
}
```

### Issue: Text too small on mobile

**Cause:** Using fixed font sizes

**Solution:**
```css
/* ✅ USE CLAMP */
body {
    font-size: clamp(0.9rem, 1.2vw, 1.1rem);
}
```

### Issue: Images distorted on mobile

**Cause:** Not maintaining aspect ratio

**Solution:**
```css
/* ✅ USE AUTO HEIGHT */
img {
    max-width: 100%;
    height: auto;  /* Maintains aspect ratio */
}
```

### Issue: Navigation menu broken on tablet

**Cause:** Not accounting for wrap/orientation

**Solution:**
```css
.navbar-nav {
    display: flex;
    flex-wrap: wrap;  /* Allow wrapping */
    gap: clamp(0.5rem, 1.5vw, 1rem);  /* Responsive gaps */
}
```

---

## Performance Optimization

### 1. Reduce Motion for Accessibility

```css
@media (prefers-reduced-motion: reduce) {
    * {
        animation-duration: 0.01ms !important;
        transition-duration: 0.01ms !important;
    }
}
```

### 2. Optimize for Print

```css
@media print {
    .no-print {
        display: none !important;
    }

    body {
        font-size: 12pt;
        line-height: 1.6;
    }

    img {
        max-width: 100%;
        page-break-inside: avoid;
    }
}
```

### 3. Future-Proof Ultra-Wide Displays

```css
@media (min-width: 2560px) {
    .container {
        max-width: 2400px;
    }

    body {
        font-size: 1.2rem;
    }
}
```

---

## Additional Resources

- [MDN: CSS Grid](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout)
- [MDN: CSS Flexbox](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout)
- [MDN: CSS clamp()](https://developer.mozilla.org/en-US/docs/Web/CSS/clamp())
- [MDN: Responsive Design](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)
- [Bootstrap 5 Responsive Grid](https://getbootstrap.com/docs/5.0/layout/grid/)

---

## Summary Checklist

- ✅ Use mobile-first approach (styles for small screens first)
- ✅ Use `box-sizing: border-box` on all elements
- ✅ Use fluid typography with `clamp()` for smooth scaling
- ✅ Use CSS Grid with `auto-fit` and `minmax()` for flexible layouts
- ✅ Use responsive images with `max-width: 100%` and `height: auto`
- ✅ Use media queries with `min-width` for progressive enhancement
- ✅ Ensure minimum 44px × 44px touch targets
- ✅ Test across real devices, not just browser emulation
- ✅ Respect user preferences (dark mode, reduced motion, etc.)
- ✅ Optimize for print using `@media print`
