# Documentary Store

A Flutter app to buy or rent digital documentaries. The app allows users to browse through a selection of documentaries, make payments securely using Stripe or Chargily, and access their purchased or rented content via email links. Built with Firebase as the backend to handle authentication, database storage, and cloud functions for payment processing.

**Note**: This app is built for learning purposes, and I do not intend to publish it to the app stores. The project uses the free version of Firebase and follows the Hexagonal Architecture for better testability and maintainability.

## Features

- Browse a variety of documentaries available for purchase or rent.
- Users can choose between buying or renting documentaries.
- Secure payment processing using Stripe or Chargily.
- Upon successful payment, a link to access the movie is sent to the user's email.

## Screenshots

![Screenshot_1725915273](https://github.com/user-attachments/assets/63964185-5909-487f-aa32-0bd1442ebaab)
![Screenshot_1725915364](https://github.com/user-attachments/assets/ec32cd10-a5dd-48a1-b139-505881c32de8)
![Screenshot_1725915368](https://github.com/user-attachments/assets/01600728-d556-430a-806a-cd6aeed793c3)
![Screenshot_1725915962](https://github.com/user-attachments/assets/21e16045-bdef-4cf5-a41f-5f2d11163198)
![Screenshot_1725916150](https://github.com/user-attachments/assets/fca3884a-79c9-4d74-afa5-88f20a11a13e)
![Screenshot_1726093543](https://github.com/user-attachments/assets/8aa17d3a-f676-4371-a624-c8949ef5203b)
![Screenshot_1725916158](https://github.com/user-attachments/assets/0a88c7b1-fbb1-49fe-8018-5aaa530c4083)
![Screenshot_1725916163](https://github.com/user-attachments/assets/0eebeb2e-b2ed-4d0a-ab4f-a64866427bf8)
![Screenshot_1725916189](https://github.com/user-attachments/assets/4e92a633-77f3-4643-96dd-e944bf20a462)

## Tech Stack

- **Flutter**: Frontend framework for building the app.
- **Firebase**: Backend services including Firestore, Cloud Functions, Authentication, and Storage.
- **Stripe & Chargily**: Payment gateways for processing transactions.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- Firebase project setup
- Stripe or Chargily account for payment processing

### Installation

1. Clone the repo:
    ```bash
    git clone https://github.com/your-username/documentary-store.git
    cd documentary-store
    ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Configure Firebase:
    - Add your `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files to the project.
    - Set up Firebase Authentication, Firestore, and Cloud Functions.
    - Use a `.secret.local` file to securely manage your secret keys:
      ```bash
      STRIPE_SECRET_KEY=
      STRIPE_WEBHOOK_SECRET=
      CHARGILY_SECRET_KEY=
      ```

4. Configure Stripe, Chargily, and other environment-specific settings:
    - This project uses `--dart-define-from-file` for environment configurations. Create `config.dev.json` and `config.prod.json` files with the following structure:
      ```json
      {
        "PAYMENT_GATEWAY": "stripe", 
        "STRIPE_PUBLISHABLE_KEY": ""
      }
      ```
    - To switch between Stripe and Chargily, update the `PAYMENT_GATEWAY` field in the config file to either `"stripe"` or `"chargily"`.
    - During the app run, you can load the desired configuration file using the `--dart-define-from-file` option:
      ```bash
      flutter run --dart-define-from-file=config.dev.json
      ```

5. Run the app:
    ```bash
    flutter run
    ```

## TDD Experience

- No need to launch the app each time for testing, which saved time.
- Focused on testing behavior (use cases) instead of implementation details.
- Served as useful documentation for the app's expected behavior.
- Made refactoring easier and safer.
- Since the app was relatively simple, I didn't fully experience the step-by-step problem-solving that TDD is known for in more complex projects.

## Contribution

Feel free to contribute by creating issues or submitting pull requests. All contributions are welcome!
