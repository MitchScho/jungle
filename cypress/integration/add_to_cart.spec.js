describe('The home page', () => {

  // it('visits succefully', () => {
  //   cy.visit('http://localhost:3000')
  // })


  it("click the Add to cart button on the page", () => {
    cy.visit('http://localhost:3000')

    cy.get(".btn")
      .first()
      .click({ force: true })
    cy.get("li.nav-item.end-0")
      .contains("My Cart (1)")
  })

  // it("Verify the total amount in cart after clicking add to cart button", () => {
  //   // cy.get("li.nav-item.end-0").should("include.text", "\n           \n          My Cart (1) \n        ")
  //   //  cy.get("li.nav-item.end-0").should("have.text", "My Cart (1)")
  //   //  cy.get("li.nav-item.end-0").expect("have.value", " My Cart (1)").to.not.be.empty
    
  // })
});