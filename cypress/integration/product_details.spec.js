
describe('The home page', () => {

  it('visits succefully', () => {
    cy.visit('http://localhost:3000')
  })

  // it("There is products on the page", () => {
  //   cy.get(".products article").should("be.visible");
  // })

  it("click a product on the page", () => {
    cy.get("[data-test=product-item]")
      .first()
      .click()
  });
  
})