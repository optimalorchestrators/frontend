describe("Testing Morning News website", () => {
    it("Search for content", () => {
        cy.visit("https://dev.dzhulc8idsfe9.amplifyapp.com/"); 
        cy.contains("Morning News");
    })
})