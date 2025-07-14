# hsh

A simple, portable shell written in Crystal with cross-platform compatibility for Linux and Windows.

## Features

- 🚀 **Cross-platform support**: Works on both Linux and Windows
- 📁 **Path completion**: Intelligent path completion for enhanced productivity
- 🔧 **Built-in commands**: Supports essential commands like `ls` and more
- 💎 **Crystal-powered**: Built with Crystal for performance and reliability
- 🎯 **Minimal compatibility**: Designed to work seamlessly across different operating systems

## Installation

### Prerequisites

- Crystal language (>= 1.16.3)

### Building from Source

```bash
git clone https://github.com/harishtpj/hsh.git
cd hsh
shards install
crystal build src/hsh.cr
```

### Running

```bash
./hsh
```

## Usage

Once you start hsh, you'll be presented with an interactive shell prompt. The shell supports:

### Built-in Commands

- `ls` - List directory contents
- Standard shell navigation and file operations
- Cross-platform path handling

### Path Completion

Press `Tab` to auto-complete file and directory paths. The completion system works intelligently across both Linux and Windows path formats.

### Example Session

```
hsh> ls
[directory contents]

hsh> cd /path/to/directory
hsh> ls *.cr
[Crystal files]
```

## Development

### Project Structure

```
src/
├── hsh.cr              # Main entry point
├── hsh/
│   ├── builtins/       # Built-in commands
│   │   └── ls.cr       # ls command implementation
│   ├── errors.cr       # Error handling
│   ├── executor.cr     # Command execution
│   ├── helpers.cr      # Utility functions
│   ├── repl.cr         # Read-Eval-Print Loop
│   └── version.cr      # Version information
└── spec/               # Test files
```

### Dependencies

- `shellwords` - Shell word parsing
- `reply` - REPL functionality
- `phreak` - Additional shell utilities

### Running Tests

```bash
crystal spec
```

### Development Setup

1. Install dependencies:
   ```bash
   shards install
   ```

2. Run in development mode:
   ```bash
   crystal run src/hsh.cr
   ```

3. Build for production:
   ```bash
   crystal build --release src/hsh.cr
   ```

## Roadmap

### Current Features (v0.1.0)
- ✅ Basic shell functionality
- ✅ Path completion
- ✅ Cross-platform compatibility (Linux/Windows)
- ✅ Built-in `ls` command

### Planned Features
- 🔄 **Enhanced built-in commands**: `cat`, `cd`, `mkdir`, `rm`, `cp`, `mv`
- 🔄 **Improved path completion**: Better fuzzy matching and context awareness
- 🔄 **User-friendly features**: 
  - Command history
  - Syntax highlighting
  - Better error messages
  - Configuration file support
- 🔄 **Advanced features**:
  - Job control
  - Environment variable management
  - Script execution
  - Pipe and redirection support

## Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

### How to Contribute

1. Fork it (<https://github.com/harishtpj/hsh/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Areas for Contribution

- Adding new built-in commands
- Improving path completion algorithms
- Enhancing cross-platform compatibility
- Writing tests and documentation
- Performance optimizations

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributors

- [Harish Kumar](https://github.com/harishtpj) - creator and maintainer
