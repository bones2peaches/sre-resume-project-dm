import { test, expect, type Page } from '@playwright/test';



test('has String', async ({ page }) => {
  const domainName :string = process.env.PW_HOST_NAME;
  const protocol : string = process.env.PW_PROTOCOL;

  
  const websiteUrl = 'http://localhost:3000/'

  // Navigate to the website
  await page.goto(websiteUrl.valueOf(), {
              waitUntil: 'domcontentloaded',
 });


  // Use the locator to find an element with the text 'Sarah Orth' and check if it is visible
  const element = page.locator('text=Home Page');
  await expect(element).toBeVisible();

//   await page.click('button:has-text("Toggle Message")');

});