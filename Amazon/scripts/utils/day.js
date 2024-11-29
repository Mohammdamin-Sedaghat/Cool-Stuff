import dayjs from 'https://unpkg.com/dayjs@1.11.10/esm/index.js';

export function makeTimeBetter(time) {
    return dayjs(time).format('MMMM DD');
}