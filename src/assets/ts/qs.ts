/**
 * @format
 */

export default function qs(selector: string) {
    const validator = /^[a-zA-Z_][a-zA-Z0-9_-]*$/;
    try {
        if (!validator.test(selector)) throw 'invalid selector!';
        if (selector.length == 0) throw 'empty selector!';
    } catch (err) {
        console.log('Error: ' + err);
    }
}
