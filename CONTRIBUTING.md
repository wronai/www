# Contributing to WronAI Projects Dashboard

Thank you for your interest in contributing to the WronAI Projects Dashboard! We welcome contributions from the community.

## Getting Started

1. **Fork the repository**
   Click the "Fork" button in the top-right corner of the repository page.

2. **Clone your fork**
   ```bash
   git clone https://github.com/your-username/www.git
   cd www
   ```

3. **Set up the development environment**
   ```bash
   # Install dependencies
   make install
   
   # Set up your GitHub token
   make token-page
   # Follow the instructions to create and save your token
   ```

4. **Start the development server**
   ```bash
   make dev
   ```
   The site will be available at http://localhost:3000

## Making Changes

1. **Create a new branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the existing code style
   - Write clear commit messages
   - Keep changes focused on a single feature or bug fix

3. **Run tests**
   ```bash
   # Run the linter
   npm run lint
   
   # Run tests (if available)
   npm test
   ```

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "Your detailed commit message"
   ```

5. **Push your changes**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to the [repository](https://github.com/wronai/www)
   - Click "New Pull Request"
   - Select your branch
   - Fill in the PR template
   - Submit the PR

## Code Style

- Use consistent indentation (2 spaces for JS/JSON, 4 spaces for Python)
- Follow the existing code style in the project
- Keep lines under 100 characters when possible
- Comment your code when necessary

## Reporting Issues

When reporting issues, please include:

1. A clear title and description
2. Steps to reproduce the issue
3. Expected vs. actual behavior
4. Browser/OS version if relevant
5. Any error messages

## License

By contributing, you agree that your contributions will be licensed under the project's [MIT License](LICENSE).
