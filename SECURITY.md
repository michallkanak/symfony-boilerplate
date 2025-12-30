# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x     | ✅ |

## Reporting a Vulnerability

We take the security of this project seriously. If you have discovered a security vulnerability, please report it responsibly.

### How to Report

1. **Do NOT** open a public GitHub issue for security vulnerabilities
2. Email the maintainer directly at **kanakmichal [at] gmail.com**
3. Include as much information as possible:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### What to Expect

- **Acknowledgment**: We will acknowledge your report within 48 hours
- **Investigation**: We will investigate and validate the vulnerability
- **Fix**: We will work on a fix and coordinate disclosure
- **Credit**: We will credit you in the release notes (unless you prefer anonymity)

### Security Best Practices

When using this boilerplate:

1. **Change default secrets**: Update `APP_SECRET` in your `.env` file
2. **Use strong passwords**: Create admin accounts with strong passwords
3. **Update regularly**: Keep all dependencies up to date
4. **Configure HTTPS**: Always use HTTPS in production
5. **Review access control**: Ensure proper role-based access

## Security Features

This boilerplate includes:

- ✅ CSRF protection on all forms
- ✅ Password hashing using Symfony's best practices
- ✅ Rate limiting on login (5 attempts per 15 minutes)
- ✅ Session-based authentication
- ✅ Role-based access control

## Dependencies

We regularly update dependencies to patch known vulnerabilities. Run these commands to check:

```bash
# Check PHP dependencies
composer audit

# Check npm dependencies  
npm audit
```
