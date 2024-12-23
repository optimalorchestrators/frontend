describe("Testing Morning News website", () => {
    it("Create a user and his password", () => {
        cy.visit("https://dev.dzhulc8idsfe9.amplifyapp.com/");
        cy.wait(4000)
        cy.get('[data-icon="user"]').click();
        cy.wait(4000);
        cy.get('#signUpUsername').type("Louis");
        cy.wait(4000);
        cy.get("#signUpPassword").type("quinze"); 
        cy.wait(4000);
        cy.get('#register').click();
        })
    });