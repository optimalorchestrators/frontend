describe("Testing Morning News website", () => {
    it("Search for content", () => {
        cy.visit("localhost:3001"); 
        cy.contains("Morning News");
    })
})