---
slug: playwright
---
https://playwright.dev/

## Fast E2E Tests

### Parallel Execution

Set `fullyParallel: true` and increase workers:

```ts
// playwright.config.ts
fullyParallel: true,
workers: process.env.CI ? 4 : undefined, // CI: fixed; local: auto (half CPU cores)
```

**Prerequisite**: tests must be isolated. Example: in [OpenSpatial](https://github.com/srid/openspatial), if each test uses a unique "room" or "space" ID, there's no cross-test state contamination and all tests can safely run in parallel.

### Cache Playwright Browsers in CI

```yaml
# .github/workflows/build.yml
- name: Cache Playwright browsers
  uses: actions/cache@v4
  with:
    path: ~/.cache/ms-playwright
    key: playwright-${{ hashFiles('package-lock.json') }}
- name: Install Playwright browsers
  run: npx playwright install --with-deps chromium
```

Saves 30-60s per run by avoiding re-downloading Chromium.

### Reduce Retries

```ts
retries: process.env.CI ? 1 : 0, // 1 retry is enough; 2 multiplies flake cost
```

### Declarative Waiting (Anti-Flake)

Never use `waitForTimeout`. Use `expect.poll` for cross-client sync assertions:

```ts
// ❌ Flaky: immediate assertion after remote action
expect(await bob.avatarOf('Alice').status()).toBe('online');

// ✅ Robust: poll until sync propagates
await expect.poll(async () => {
  return await bob.avatarOf('Alice').status();
}, { timeout: 5000 }).toBe('online');
```

**Important**: DSL query methods used inside `expect.poll` must be *quick snapshots* (return current state immediately). If they internally wait N seconds for an element, each poll iteration blocks N seconds, defeating the poll timeout. Use `isVisible()` instead of `expect(...).toBeVisible({ timeout })` in such methods.

### Menu Interactions

Don't use `force: true` on menu option clicks — it bypasses visibility checks. Wait for the menu to render:

```ts
await menuButton.click();
await option.waitFor({ state: 'visible' });
await option.click();
```
