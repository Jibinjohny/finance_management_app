import json
import os

def fix_localization():
    # Load English translations (source of truth)
    with open('lib/l10n/app_en.arb', 'r') as f:
        en_data = json.load(f)

    # Load untranslated keys report
    try:
        with open('untranslated.json', 'r') as f:
            untranslated_report = json.load(f)
    except FileNotFoundError:
        print("untranslated.json not found. Please run 'flutter gen-l10n' first.")
        return

    # Iterate through each language in the report
    for lang, missing_keys in untranslated_report.items():
        arb_file = f'lib/l10n/app_{lang}.arb'
        
        if not os.path.exists(arb_file):
            print(f"Warning: {arb_file} does not exist. Skipping.")
            continue

        print(f"Fixing {lang}...")
        
        # Load existing translations for the language
        try:
            with open(arb_file, 'r') as f:
                lang_data = json.load(f)
        except json.JSONDecodeError:
            print(f"Error decoding {arb_file}. Skipping.")
            continue

        # Add missing keys with English values
        added_count = 0
        for key in missing_keys:
            if key in en_data:
                lang_data[key] = en_data[key]
                added_count += 1
                
                # Also copy metadata if it exists (e.g. @key)
                meta_key = f"@{key}"
                if meta_key in en_data:
                    lang_data[meta_key] = en_data[meta_key]
            else:
                print(f"Warning: Key '{key}' missing in app_en.arb too!")

        # Save the updated file
        with open(arb_file, 'w', encoding='utf-8') as f:
            json.dump(lang_data, f, indent=2, ensure_ascii=False)
        
        print(f"  Added {added_count} missing keys to {arb_file}")

if __name__ == "__main__":
    fix_localization()
