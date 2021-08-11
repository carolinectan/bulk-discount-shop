# Extensions

* When an invoice is pending, a merchant should not be able to delete or edit a bulk discount that applies to any of their items on that invoice.
* When an Admin marks an invoice as “completed”, then the discount percentage should be stored on the invoice item record so that it can be referenced later
* Merchants should not be able to create/edit bulk discounts if they already have a discount in the system that would prevent the new discount from being applied (see example 4)

## Holiday Discount Extensions

```
Create a Holiday Discount

As a merchant,
when I visit the discounts index page,
In the Holiday Discounts section, I see a `create discount` button next to each of the 3 upcoming holidays.
When I click on the button I am taken to a new discount form that has the form fields auto populated with the following:

Discount name: <name of holiday> discount
Percentage Discount: 30
Quantity Threshold: 2

I can leave the information as is, or modify it before saving.
I should be redirected to the discounts index page where I see the newly created discount added to the list of discounts.
```

```
View a Holiday Discount

As a merchant (if I have created a holiday discount for a specific holiday),
when I visit the discount index page,
within the `Upcoming Holidays` section I should not see the button to 'create a discount' next to that holiday,
instead I should see a `view discount` link.
When I click the link I am taken to the discount show page for that holiday discount.
```
