## Stripe Connect Marketplace::Managed Accounts
================================================================================
Stripe Connect is one of the most flexible PCI compliant marketplace APIs in existence today. This application is a marketplace skeleton based on Stripe's Managed Merchant Accounts and payment processing already built and ready to go out of the box.

Structurally, this app has a `Customer` model and a `Merchant` model, both of which are nested under the `User` model. The `User` model was originated and modified using the Devise gem.

The `Merchant` is associated with Stripe Connect::Managed Accounts. You can grab the account object and modify it however you see fit. Currently, it has account verification and bank account set up (using tokenization) in place.

The `Gift` model is a placeholder for any widgets or services that need to be sold through the marketplace. Payment processing is already handled by first creating the `card` object. Then tokenizing it and creating the `charge` object.

Learn more about Stripe Connect::Managed Accounts here: https://stripe.com/docs/connect/managed-accounts
