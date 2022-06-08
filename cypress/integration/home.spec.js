

describe('The home page', () => {
  // beforeEach(() => {
    
  //   cy.visit('https://example.cypress.io/todo')
  // })

  it('visits succefully', () => {
    cy.visit('http://localhost:3000')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  })

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

})