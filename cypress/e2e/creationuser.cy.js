describe("Testing Morning News website", () => {
    it("Create a user and his password", () => {
        cy.visit("localhost:3001");
        // cy.get("li").within();
        cy.wait(4000)
        // cy.get('.Header_header__VYZ3G').click();
        cy.get('[data-icon="user"]').click();
        cy.wait(4000);
        cy.get('#signUpUsername').type("Louis");
        cy.wait(4000);
        cy.get("#signUpPassword").type("quinze"); 
        cy.wait(4000);
        cy.get('#register').click();
        })
    });